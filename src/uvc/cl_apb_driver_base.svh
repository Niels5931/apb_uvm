class cl_apb_driver_base extends uvm_driver#(cl_apb_seq_item, cl_apb_seq_item);

  process main_loop_h;
  cl_apb_config cfg;

  `uvm_component_utils(cl_apb_driver_base)

  function new(string name = "cl_apb_driver_base", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(cl_apb_config)::get(this,"","cfg",this.cfg)) begin
      `uvm_fatal("APB Driver Base", "Could not find config object")
    end
  endfunction : build_phase

  virtual task main_phase(uvm_phase phase);
    fork
      handle_reset();
      start_loop();
    join_none
  endtask : main_phase

  task handle_reset();
    fork
      forever begin
        if (this.cfg.vif.PRESETn === 0) begin
          if (main_loop_h != null) begin
            main_loop_h.kill();
            this.seq_item_port.item_done();
          end
          drive_reset();
          wait(this.cfg.vif.PRESETn === 1);
        end
        @(posedge this.cfg.vif.PCLK);
      end
    join_none
  endtask : handle_reset

  task start_loop;
    main_loop_h = process::self();
    while(this.cfg.vif.PRESETn !== 1) begin
      @(posedge this.cfg.vif.PCLK);
    end
    main_loop();
  endtask : start_loop

  task main_loop;
    forever begin
      this.seq_item_port.get_next_item(this.req);
      $cast(this.rsp,this.req.clone());
      this.rsp.set_id_info(this.req);
      this.drive_pins();
      this.seq_item_port.put_response(this.rsp);
      this.seq_item_port.item_done();
    end
  endtask : main_loop

  virtual function void drive_reset();
    `uvm_fatal("Driver Base", "Error! drive_reset must be implemented by master/slave")
  endfunction : drive_reset

  virtual task drive_pins();
    `uvm_fatal("Driver Base", "Error! drive_pins must be implemented by master/slave")
  endtask : drive_pins


endclass : cl_apb_driver_base
