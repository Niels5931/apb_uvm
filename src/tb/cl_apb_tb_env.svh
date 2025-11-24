class cl_apb_tb_env extends uvm_env;

  cl_apb_agent      apb_manager_agent;
  cl_apb_agent      apb_subordinate_agent;
  cl_apb_tb_vseqr   sequencer;
  cl_apb_tb_config  cfg;

  `uvm_component_utils(cl_apb_tb_env)

  function new(string name = "cl_apb_tb_env", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    this.cfg = cl_apb_tb_config::type_id::create("cl_apb_tb_cfg");

    this.sequencer = cl_apb_tb_vseqr::type_id::create("apb_virtual_sequencer",this);

    uvm_config_db#(cl_apb_config)::set(this,"apb_manager_agent","cfg",this.cfg.apb_manager_cfg);
    this.apb_manager_agent = cl_apb_agent::type_id::create("apb_manager_agent",this);

    uvm_config_db#(cl_apb_config)::set(this,"apb_subordinate_agent","cfg",this.cfg.apb_subordinate_cfg);
    this.apb_subordinate_agent = cl_apb_agent::type_id::create("apb_subordinate_agent",this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    this.sequencer.apb_manager_seqr     = this.apb_manager_agent.sequencer;
    this.sequencer.apb_subordinate_seqr = this.apb_subordinate_agent.sequencer;
  endfunction : connect_phase

endclass : cl_apb_tb_env
