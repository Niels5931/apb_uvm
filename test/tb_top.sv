import uvm_pkg::*;

module tb_top;
  
  logic PCLK = 0;
  logic PRESETn = 1;

  always #5 PCLK = ~PCLK;
  initial begin
    #12 PRESETn = 0;
  end

  if_apb apb_if(.PCLK(PCLK),.PRESETn(PRESETn));

  initial begin
    uvm_config_db#(virtual if_apb.master)::set(uvm_root::get(),"*","vif",apb_if.master);
    uvm_config_db#(virtual if_apb.slave)::set(uvm_root::get(),"*","vif",apb_if.slave);
  end

  initial begin
    run_test();
  end
endmodule
