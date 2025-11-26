class cl_apb_driver_subordinate extends cl_apb_driver_base;

  `uvm_component_utils(cl_apb_driver_subordinate)

  function new(string name = "cl_apb_driver_subordinate", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

  virtual function void drive_reset();
    this.cfg.vif.PREADY <= 'bx;
    this.cfg.vif.PRDATA <= 'bx;
    this.cfg.vif.PSLVERR <= 'bx;
  endfunction : drive_reset

  virtual task drive_pins();
    // wait until PSEL is high
    do begin
      @(posedge this.cfg.vif.PCLK);
    end while (this.cfg.vif.PSEL !== 1'b1);

    repeat(this.req.delay) @(posedge this.cfg.vif.PCLK);

    this.cfg.vif.PREADY <= 1'b1;
    this.cfg.vif.PSLVERR <= this.req.resp;

    if (this.req.op === pk_apb::RD) begin
      this.cfg.vif.PRDATA <= this.req.data;
    end

    do begin
      @(posedge this.cfg.vif.PCLK);
    end while (this.cfg.vif.PENABLE !== 1'b1);

    this.drive_reset();

  endtask : drive_pins

endclass : cl_apb_driver_subordinate
