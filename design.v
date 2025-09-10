module sp_ram (
  input clk,
  input rst,
  input wren,
  input [3:0] addrs,
  input [7:0] data_in,
  output reg [7:0] data_out
);

  reg [7:0] mem[0:15];

  always @(posedge clk) begin
    if(rst) begin
      data_out <=0;
    end
    else if(wren)
      mem[addrs] <= data_in;
    else
      data_out <= mem[addrs];
  end
endmodule
