class cl_apb_driver_manager extends cl_apb_driver_base;

  `uvm_component_utils(cl_apb_driver_manager)

  function new(string name = "cl_apb_driver_manager", uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual if_apb.master)::get(this,"","vif",this.vif)) begin
      `uvm_fatal("Driver Manager", "Error! Could not retrieve APB master interface")
    end
  endfunction : build_phase

  virtual function void drive_reset();
    this.vif.PSEL <= '0;
    this.vif.PENABLE <= '0;
    this.vif.PADDR <= '0;
    this.vif.PWRITE <= '0;
    this.vif.PWDATA <= '0;
    this.vif.PSTRB <= '0;
    this.vif.PPROT <= '0;
  endfunction : drive_reset

  virtual task drive_pins();
    // RD/WR
    if (this.req.op === pk_apb::WR) begin
      this.vif.PWRITE <= 1'b1;
    end else if (this.req.op == pk_apb::RD) begin
      this.vif.PWRITE <= 1'b0;
    end
    this.vif.PSEL <= 1'b1;
    this.vif.PADDR <= this.req.addr;
    @(posedge this.vif.PCLK);
    this.vif.PENABLE <= 1'b1;
    this.rsp.resp = resp_type'(this.vif.PSLVERR);
    //do begin
    //  @(posedge this.vif.PCLK);
    //end while (this.vif.PREADY === 1'b0);
    @(posedge this.vif.PCLK);
  endtask : drive_pins

endclass : cl_apb_driver_manager
