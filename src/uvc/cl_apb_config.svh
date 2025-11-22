class cl_apb_config extends uvm_object;

  active_type active;
  driver_type driver;

  `uvm_object_utils_begin(cl_apb_config)
    `uvm_field_enum(active_type, active, UVM_DEFAULT)
    `uvm_field_enum(driver_type, driver, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "cl_apb_config");
    super.new(name);
    active = __NOTDRIVEN;
    driver = __NOTSET;
  endfunction

endclass : cl_apb_config
