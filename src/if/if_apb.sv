interface if_apb(
  input logic PCLK,
  input logic PRESETn
);

  logic PSEL;
  logic PENABLE;
  logic PADDR;
  logic PREADY;
  logic PSLVERR;
  logic PWRITE;
  logic [31:0] PRDATA;
  logic [31:0] PWDATA;
  logic [ 3:0] PSTRB;
  logic [ 2:0] PPROT;

  modport master (
    input PRDATA,
    input PREADY,
    input PSLVERR,
    output PSEL,
    output PENABLE,
    output PADDR,
    output PWRITE,
    output PWDATA,
    output PSTRB,
    output PPROT
  );

  modport slave (
    input PSEL,
    input PENABLE,
    input PADDR,
    input PWRITE,
    input PWDATA,
    input PSTRB,
    input PPROT,
    output PRDATA,
    output PREADY,
    output PSLVERR
  );

endinterface : if_apb

