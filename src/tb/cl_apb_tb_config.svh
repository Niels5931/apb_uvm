class cl_apb_tb_config extends uvm_object;

  virtual if_clk clk_if;

  `uvm_object_utils(cl_apb_tb_config)

  function new(string name = "cl_apb_tb_config");
    super.new(name);
  endfunction

endclass : cl_apb_tb_config
