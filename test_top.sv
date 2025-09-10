`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "package.sv"
//`include "spr_test.sv"
//`include "base_test2.sv"

module tb_top;
  bit clk;
  bit rst;

  always #5ns clk = ~clk;

  initial begin
    clk =0;
    rst=1;
    #20ns;
    rst=0;
  end

  intf vif(clk,rst);

  sp_ram dut(
    .clk(vif.clk),
    .rst(vif.rst),
    .wren(vif.wren),
    .addrs(vif.addrs),
    .data_in(vif.data_in),
    .data_out(vif.data_out)
  );

  initial begin
    uvm_config_db#(virtual intf)::set(uvm_root::get(),"*","vif",vif);
  end
  
  initial begin
    //run_test("write_full_then_read_test");
    run_test("base_test");
  end
  initial begin
 
  $dumpfile("dump.vcd"); 
    $dumpvars(0,tb_top); 
end
    
endmodule
