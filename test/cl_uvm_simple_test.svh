import uvm_pkg::*;
`include "uvm_macros.svh"
class cl_uvm_simple_test extends uvm_test;

  `uvm_component_utils(cl_uvm_simple_test)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void run_phase(uvm_phase phase);
    `uvm_info("Simple Test","Hello world!",UVM_MEDIUM)
  endfunction : run_phase

endclass : cl_uvm_simple_test
