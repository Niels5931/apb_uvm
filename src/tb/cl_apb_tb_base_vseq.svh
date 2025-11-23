class cl_apb_tb_base_vseq extends uvm_sequence;

  `uvm_declare_p_sequencer(pk_apb_tb::cl_apb_tb_vseqr)

  `uvm_object_utils(cl_apb_tb_base_vseq)

  function new(string name = "cl_apb_tb_base_vseq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_fatal("cl_apb_tb_base_vseq","Error! Base vseq must be overwritten")
  endtask : body

endclass : cl_apb_tb_base_vseq
