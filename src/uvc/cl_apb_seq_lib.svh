
class cl_apb_base_seq extends uvm_sequence#(.REQ(cl_apb_seq_item),.RSP(cl_apb_seq_item));

  cl_apb_seq_item s_item;

  `uvm_object_utils(cl_apb_base_seq)


  function new(string name = "cl_apb_base_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_fatal("cl_apb_base_seq","Seq must override task body")
  endtask : body

endclass : cl_apb_base_seq

class cl_apb_single_seq extends cl_apb_base_seq;

  `uvm_object_utils(cl_apb_single_seq)

  function new(string name = "cl_apb_single_seq");
    super.new(name);
  endfunction

  virtual task body();
    // the seq item is created and randomized if not set during simulation
    start_item(s_item);
    //if (!s_item.randomize()) begin
    //  `uvm_fatal("cl_apb_single_seq","Failed to randomize seq item!")
    //end

    finish_item(s_item);
    //get_response(s_item);

  endtask : body

  function void pre_randomize();
    pre_randomize();
    if (this.s_item == null) begin
      this.s_item = cl_apb_seq_item::type_id::create();
      if (!this.s_item.randomize()) begin
        `uvm_fatal("cl_apb_single_seq","Failed to randomize seq item!")
      end
    end

  endfunction : pre_randomize

endclass : cl_apb_single_seq
