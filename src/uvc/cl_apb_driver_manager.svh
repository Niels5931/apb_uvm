class cl_apb_driver_manager extends cl_apb_driver_base;

  `uvm_component_utils(cl_apb_driver_manager)

  function new(string name = "cl_apb_driver_manager", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

  virtual function void drive_reset();
    this.cfg.vif.PSEL <= '0;
    this.cfg.vif.PENABLE <= '0;
    this.cfg.vif.PADDR <= '0;
    this.cfg.vif.PWRITE <= '0;
    this.cfg.vif.PWDATA <= '0;
    this.cfg.vif.PSTRB <= '0;
    this.cfg.vif.PPROT <= '0;
  endfunction : drive_reset

  virtual task drive_pins();
    // RD/WR
    if (this.req.op === pk_apb::WR) begin
      this.cfg.vif.PWRITE <= 1'b1;
    end else if (this.req.op == pk_apb::RD) begin
      this.cfg.vif.PWRITE <= 1'b0;
    end
    this.cfg.vif.PSEL <= 1'b1;
    this.cfg.vif.PADDR <= this.req.addr;
    @(posedge this.cfg.vif.PCLK);
    this.cfg.vif.PENABLE <= 1'b1;
    if (this.req.op == pk_apb::WR) begin
      this.cfg.vif.PWDATA <= this.req.data;
    end
    while (this.cfg.vif.PREADY !== 1'b1) begin
      @(posedge this.cfg.vif.PCLK);
    end
    //@(posedge this.cfg.vif.PCLK);
    this.rsp.resp = resp_type'(this.cfg.vif.PSLVERR);
    if (this.req.op == pk_apb::RD) begin
      this.rsp.data = this.cfg.vif.PRDATA;
    end
    this.drive_reset();
  endtask : drive_pins

endclass : cl_apb_driver_manager
