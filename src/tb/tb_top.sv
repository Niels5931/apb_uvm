`timescale 1ns/1ns
module tb_top;

  import uvm_pkg::*;
  import pk_apb_tests::*;

  `include "uvm_macros.svh"
  logic PCLK = 0;
  logic PRESETn;

  always #5 PCLK = ~PCLK;

  if_clk clk_if(.PCLK(PCLK),.PRESETn(PRESETn));
  if_apb apb_if(.PCLK(clk_if.PCLK),.PRESETn(clk_if.PRESETn));


  initial begin
    uvm_config_db#(virtual if_clk)::set(uvm_root::get(),"","clk_if",clk_if);
    uvm_config_db#(virtual if_apb.master)::set(uvm_root::get(),"","vif",apb_if.master);
    uvm_config_db#(virtual if_apb.slave)::set(uvm_root::get(),"","vif",apb_if.slave);
  end

  initial begin
    run_test();
  end

  initial begin
    $dumpfile("trace.vcd");
    $dumpvars(0, tb_top);
    // VCD dump, but can be "fixed" by assigning a value to the signal in the
    // interface before running the simulation
    apb_if.PSEL = 0;
    apb_if.PENABLE = 0;
    //apb_if.PADDR = 0;
    //apb_if.PREADY = 0;
    //apb_if.PSLVERR = 0;
    //apb_if.PWRITE = 0;
    //apb_if.PRDATA = 0;
    //apb_if.PWDATA = 0;
    //apb_if.PSTRB = 0;
    //apb_if.PPROT = 0;
  end
endmodule
