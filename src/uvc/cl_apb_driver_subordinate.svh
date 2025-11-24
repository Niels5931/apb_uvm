class cl_apb_driver_subordinate extends cl_apb_driver_base;

  `uvm_component_utils(cl_apb_driver_subordinate)

  function new(string name = "cl_apb_driver_subordinate", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual if_apb.slave)::get(this,"","vif",this.vif)) begin
      `uvm_fatal("Driver Slave", "Error! Could not retrieve APB master interface")
    end
  endfunction : build_phase

  virtual function void drive_reset();
    this.vif.PREADY <= 'bx;
    this.vif.PRDATA <= 'bx;
    this.vif.PSLVERR <= 'bx;
  endfunction : drive_reset

  virtual task drive_pins();
    // wait until PSEL is high
    do begin
      @(posedge this.vif.PCLK);
    end while (this.vif.PSEL !== 1'b1);
    while (this.vif.PENABLE !== 1'b1) begin
      @(posedge this.vif.PCLK);
    end
    repeat(this.req.delay) @(posedge this.vif.PCLK);

    this.vif.PREADY <= 1'b1;
    this.vif.PSLVERR <= this.req.resp;

    if (this.req.op === pk_apb::RD) begin
      this.vif.PRDATA <= this.req.data;
    end

    @(posedge this.vif.PCLK);

    this.drive_reset();

  endtask : drive_pins

endclass : cl_apb_driver_subordinate
