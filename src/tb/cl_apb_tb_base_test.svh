class cl_apb_tb_base_test extends uvm_test;

  cl_apb_tb_env     env;
  cl_apb_tb_config  cfg;
  cl_apb_tb_base_vseq  seq;

  `uvm_component_utils(cl_apb_tb_base_test)

  function new (string name,uvm_component parent);
    super.new(name,parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = cl_apb_tb_env::type_id::create("env", this);
    cfg = cl_apb_tb_config::type_id::create("cfg");
    if (!uvm_config_db#(virtual if_clk)::get(this,"","clk_if",this.cfg.clk_if)) begin
      `uvm_fatal("cl_apb_tb_base_test","Error! Couldnt get clk if")
    end
    uvm_config_db#(cl_apb_tb_config)::set(this, "*", "test_cfg", cfg);
  endfunction : build_phase

  task reset_phase(uvm_phase phase);
    super.reset_phase(phase);
    this.cfg.clk_if.PRESETn <= 1'b0;
    repeat ($urandom_range(1,100)) @(posedge this.cfg.clk_if.PCLK);
    this.cfg.clk_if.PRESETn <= 1'b1;
    `uvm_info("cl_apb_tb_base_test","Release reset",UVM_MEDIUM)
  endtask : reset_phase

  task main_phase(uvm_phase phase);
    seq = cl_apb_tb_base_vseq::type_id::create("seq",this);
    phase.raise_objection(this);
    seq.start(env.sequencer);
    phase.drop_objection(this);
  endtask : main_phase

  task shutdown_phase(uvm_phase phase);
    super.shutdown_phase(phase);
    repeat(10) @(posedge this.cfg.clk_if.PCLK);
    `uvm_info("cl_apb_tb_base_test","Base test finished",UVM_MEDIUM)
  endtask : shutdown_phase

endclass : cl_apb_tb_base_test
