class cl_apb_tb_config extends uvm_object;

  if_clk clk_if;

  `uvm_object_utils(cl_apb_tb_config)

  function new(string name = "cl_apb_tb_config");
    super.new(name);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(if_clk)::get(this,"",clk_if,this.clk_if)) begin
      `uvm_fatal("cl_apb_tb_config","Error! clk_if not parsed")
    end
  endfunction : build_phase

endclass : cl_apb_tb_config
