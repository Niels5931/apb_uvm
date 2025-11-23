module tb_top;

  import uvm_pkg::*;

  logic PCLK = 0;
  logic PRESETn = 1;

  always #5 PCLK = ~PCLK;
  initial begin
    #12 PRESETn = 0;
  end

  if_clk clk_if(.PCLK(PCLK),.PRESETn(PRESETn));
  if_apb apb_if(.PCLK(clk_if.PCLK),.PRESETn(clk_if.PRESETn));

  initial begin
    uvm_config_db#(virtual if_clk)::set(uvm_root::get(),"","clk_if",clk_if);
    uvm_config_db#(virtual if_apb.master)::set(uvm_root::get(),"","vif",apb_if.master);
    uvm_config_db#(virtual if_apb.slave)::set(uvm_root::get(),"","vif",apb_if.slave);
  end

  initial begin
    run_test("cl_apb_tb_simple_test");
  end
endmodule
