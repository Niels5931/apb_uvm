class cl_apb_tb_vseqr extends uvm_sequencer;

  uvm_sequencer#(cl_apb_seq_item) apb_manager_seqr;
  uvm_sequencer#(cl_apb_seq_item) apb_subordinate_seqr;

  `uvm_component_utils(cl_apb_tb_vseqr)

  function new(string name = "cl_apb_tb_vseqr", uvm_component parent);
    super.new(name,parent);
  endfunction

endclass : cl_apb_tb_vseqr
