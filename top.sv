`include"dut.sv"
`include"interface.sv"
`include"packet.sv"
`include"generator.sv"
`include"driver.sv"
`include"imonitor.sv"
`include"coverage.sv"
`include"omonitor.sv"
`include"scoreboard.sv"
`include"environment.sv"
`include"test.sv"
`include"testbench.sv"
module top;
reg clk;
initial clk=0;
always #5 clk=~clk;
ram_if inst_intf(clk);
ram_dut dut(.clk(clk),.rst(inst_intf.rst),.wr(inst_intf.wr),.wdata(inst_intf.wdata),.addr(inst_intf.addr),.rdata(inst_intf.rdata));

testbench tb(inst_intf);
endmodule