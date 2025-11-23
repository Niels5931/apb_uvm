class cl_apb_tb_simple_test extends pk_apb_tb::cl_apb_tb_base_test;

  `uvm_component_utils(cl_apb_tb_simple_test)

  function new(string name = "cl_apb_tb_simple_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    set_type_override_by_type(pk_apb_tb::cl_apb_tb_base_vseq::get_type(),pk_apb_vseqs::cl_apb_tb_simple_vseq::get_type());
  endfunction : build_phase

endclass : cl_apb_tb_simple_test
