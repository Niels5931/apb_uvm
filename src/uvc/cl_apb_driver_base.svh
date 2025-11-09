class cl_apb_driver_base extends uvm_driver#(cl_apb_seq_item);

  virtual if_apb vif;
  process main_loop_h;

  `uvm_component_utils(cl_apb_driver_base)
   
  function new(string name = "cl_apb_driver_base", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
    forever begin
      fork 
        begin
          handle_reset();
        end
        begin
          main_loop();
        end
      join_none
    end
  endtask : run_phase

  task handle_reset();
    if (this.apb_if.PRESETn === 0) begin
      if (main_loop_h != null) begin
        main_loop_h.kill();
        this.seq_item_port.item_done();
      end
      drive_reset();
      do begin
        @(posedge this.apb_if.PCLK);
      end while (this.apb_if.PRESETn === 0);
    end
  endtask : handle_reset

  task main_loop;
    main_loop_h = process::self();
    forever begin
      this.seq_item_port.get_next_item(this.req);
      $cast(this.rsp,this.req.clone());
      drive_pins();
      this.seq_item_port.put_response(this.rsp);
      this.seq_item_port.item_done();
    end
  endtask : main_loop
  
  function void drive_reset();
    `uvm_fatal("Driver Base", "Error! drive_reset must be implemented by master/slave")
  endfunction : drive_reset

  virtual task drive_pins();
    `uvm_fatal("Driver Base", "Error! drive_pins must be implemented by master/slave")
  endtask : drive_pins
    

endclass : cl_apb_driver_base
