interface intf(input logic clk, rst);
  logic wren;
  logic [3:0] addrs;
  logic [7:0] data_in;
  logic [7:0] data_out;
endinterface
