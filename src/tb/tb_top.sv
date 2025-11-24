`timescale 1ns/1ns
module tb_top;

  import uvm_pkg::*;
  import pk_apb_tests::*;

  `include "uvm_macros.svh"
  logic PCLK = 0;

  always #5 PCLK = ~PCLK;

  if_clk clk_if(.PCLK(PCLK));
  if_apb apb_if(.PCLK(clk_if.PCLK),.PRESETn(clk_if.PRESETn));

  apb_stub dut (
    .if_apb(apb_if)
  );

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
  end
endmodule
