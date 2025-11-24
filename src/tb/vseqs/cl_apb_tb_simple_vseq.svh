class cl_apb_tb_simple_vseq extends pk_apb_tb::cl_apb_tb_base_vseq;

  `uvm_object_utils(cl_apb_tb_simple_vseq)

  function new(string name = "cl_apb_tb_simple_vseq");
  super.new(name);
  endfunction

  task body();

    pk_apb::cl_apb_seq_item apb_item;
    apb_item = pk_apb::cl_apb_seq_item::type_id::create();

    if (!apb_item.randomize()) begin
      `uvm_fatal("cl_apb_tb_simple_vseq", "Error! Failed to randomize apb_item")
    end

    // split manager and subordinate
    fork
      // manager
      begin
        pk_apb::cl_apb_seq_item mgmt_apb_item;
        pk_apb::cl_apb_single_seq mgmt_apb_seq;
        mgmt_apb_seq = pk_apb::cl_apb_single_seq::type_id::create("mgmt_apb_seq");
        if (!($cast(mgmt_apb_item,apb_item.clone()))) begin
          `uvm_fatal("cl_apb_tb_simple_vseq","Error! Couldn't clone seq item")
        end
        mgmt_apb_seq.s_item = mgmt_apb_item;
        mgmt_apb_seq.start(p_sequencer.apb_manager_seqr);
        `uvm_info("cl_apb_simple_test", $sformatf("APB mgmt seq %s", mgmt_apb_item.sprint()), UVM_MEDIUM)
      end
      begin
        pk_apb::cl_apb_seq_item sbnt_apb_item;
        pk_apb::cl_apb_single_seq sbnt_apb_seq;
        sbnt_apb_seq = pk_apb::cl_apb_single_seq::type_id::create("sbnt_apb_seq");
        if (!($cast(sbnt_apb_item,apb_item.clone()))) begin
          `uvm_fatal("cl_apb_tb_simple_vseq","Error! Couldn't clone seq item")
        end
        sbnt_apb_seq.s_item = sbnt_apb_item;
        sbnt_apb_seq.start(p_sequencer.apb_subordinate_seqr);
        `uvm_info("cl_apb_simple_test", $sformatf("APB sbnt seq %s", sbnt_apb_item.sprint()), UVM_MEDIUM)
      end
    join

  endtask : body

endclass : cl_apb_tb_simple_vseq
