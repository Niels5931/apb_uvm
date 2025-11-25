class cl_apb_driver_base extends uvm_driver#(cl_apb_seq_item, cl_apb_seq_item);

  process main_loop_h;
  cl_apb_config cfg;

  `uvm_component_utils(cl_apb_driver_base)

  function new(string name = "cl_apb_driver_base", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

  virtual task main_phase(uvm_phase phase);
    fork
      begin
        forever handle_reset();
      end
      begin
        start_loop();
      end
    join_none
  endtask : main_phase

  task handle_reset();
    if (this.vif.PRESETn === 0) begin
      if (main_loop_h != null) begin
        main_loop_h.kill();
        this.seq_item_port.item_done();
      end
      drive_reset();
      wait(this.vif.PRESETn === 1);
    end
    @(posedge this.vif.PCLK);
  endtask : handle_reset

  task start_loop;
    while(this.vif.PRESETn !== 1) begin
      @(posedge this.vif.PCLK);
    end
    main_loop();
  endtask : start_loop

  task main_loop;
    main_loop_h = process::self();
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
