class cl_apb_tb_config extends uvm_object;

  virtual if_clk clk_if;

  pk_apb::cl_apb_config apb_manager_cfg;
  pk_apb::cl_apb_config apb_subordinate_cfg;

  `uvm_object_utils(cl_apb_tb_config)

  function new(string name = "cl_apb_tb_config");
    super.new(name);

    this.apb_manager_cfg = pk_apb::cl_apb_config::type_id::create("apb_manager_cfg");
    this.apb_manager_cfg.driver = pk_apb::MASTER;
    this.apb_manager_cfg.active = pk_apb::ACTIVE;

    this.apb_subordinate_cfg = pk_apb::cl_apb_config::type_id::create("apb_subordinate_cfg");
    this.apb_subordinate_cfg.driver = pk_apb::SLAVE;
    this.apb_subordinate_cfg.active = pk_apb::ACTIVE;

  endfunction

endclass : cl_apb_tb_config
