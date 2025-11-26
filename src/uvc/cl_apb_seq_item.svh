
class cl_apb_seq_item extends uvm_sequence_item;

  rand bit [31:0] data;
  rand bit [31:0] addr;
  rand resp_type  resp;
  rand op_type    op; // RD or WR
  rand int        delay; // delay clock cycles before slave accepting request

  `uvm_object_utils_begin(cl_apb_seq_item)
    `uvm_field_int(data,            UVM_DEFAULT)
    `uvm_field_int(addr,            UVM_DEFAULT)
    `uvm_field_enum(resp_type,resp, UVM_DEFAULT)
    `uvm_field_enum(op_type,op,     UVM_DEFAULT)
    `uvm_field_int(delay,           UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "cl_apb_seq_item");
    super.new(name);
  endfunction

  constraint seq_item_delay_c {
    this.delay == 0;
  };

endclass : cl_apb_seq_item
