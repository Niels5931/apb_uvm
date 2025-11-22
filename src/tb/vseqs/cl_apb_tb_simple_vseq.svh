class cl_apb_tb_simple_vseq extends pk_apb_tb::cl_apb_tb_base_vseq;

  `uvm_component_utils(cl_apb_tb_simple_vseq)

  function new(string name = "cl_apb_tb_simple_vseq");
  super.new(name);
  endfunction

  task body();

    pk_apb::cl_apb_seq_item abp_item;
    abp_item = pk_apb::cl_apb_seq_item::type_id::create();

    if (!apb_item.randomize()) begin
      `uvm_fatal("cl_apb_tb_simple_vseq", "Error! Failed to randomize apb_item")
    end

    // split manager and subordinate
    fork
      // manager
      begin
        pk_apb::cl_apb_seq_item mgmt_apb_item;
        pk_apb::cl_apb_single_seq mgmt_apb_seq;
        if (!($clone(mgmt_apb_item,apb_item))) begin
          `uvm_fatal("cl:cl_apb_tb_simple_vseq","Error! Couldn't clone seq item")
        end
        mgmt_apb_seq.s_item = mgmt_apb_item;
        mgmt_apb_seq.start(this.env.sequencer.apb_manager_seqr);
        `uvm_info("cl_apb_simple_test","APB mgmt seq %s",mgmt_apb_item.sprintf())
      end
    join

  endtask : body

endclass : cl_apb_tb_simple_vseq
