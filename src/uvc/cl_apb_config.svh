class cl_apb_config extends uvm_object;

  active_type is_active;

  `uvm_object_utils_begin(cl_apb_config)
    `uvm_field_enum(active_type, is_active, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "cl_apb_config");
    super.new(name);
    is_active = __NOTSET;
  endfunction


endclass : cl_apb_config
