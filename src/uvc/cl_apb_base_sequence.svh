class cl_apb_base_sequence extends uvm_sequence #(cl_apb_seq_item);

  `uvm_object_utils(cl_apb_base_sequence)

  function new (string name = "cl_apb_base_sequence");
    super.new(name);
  endfunction : new

  virtual task body();
    cl_apb_seq_item req;

    // Example of creating, randomizing, and sending a sequence item
    req = cl_apb_seq_item::type_id::create("req");
    start_item(req);
    if (!req.randomize()) begin
      `uvm_error(get_full_name(), "Failed to randomize sequence item")
    end
    `uvm_info(get_full_name(), $sformatf("Sending sequence item: %s", req.sprint()), UVM_LOW)
    finish_item(req);

    // You can add more complex sequence logic here,
    // such as looping, waiting for events, or calling other sequences.
  endtask : body

endclass : cl_apb_base_sequence
