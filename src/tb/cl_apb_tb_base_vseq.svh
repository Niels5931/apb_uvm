class cl_apb_tb_base_vseq extends uvm_sequence;

  `uvm_component_utils(cl_apb_tb_base_vseq)

  function new(string name = "cl_apb_tb_base_vseq",uvm_component parent);
    super.new(name,parent);
  endfunction

  virtual task body();
    `uvm_fatal("cl_apb_tb_base_vseq","Error! Base vseq must be overwritten")
  endtask : body

endclass : cl_apb_tb_base_vseq
