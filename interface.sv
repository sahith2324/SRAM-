//interface block
interface ram_if(input clk);
logic rst,wr; // 2 bit inputs
logic[7:0]wdata;
logic[3:0]addr;
logic[7:0]rdata;


 // clocking block for driver
 
clocking cb_driver @(posedge clk);
input rdata;
output wr;
output wdata;
output addr;
endclocking

//clocking block for imonitor
clocking cb_imon @(posedge clk);
input wdata;
input addr;
endclocking

//clocking block for omonitor
clocking cb_omon@(posedge clk);
input rdata;
endclocking
 
modport tb_driver(clocking cb_driver,output rst);
modport tb_imon(clocking cb_imon);
modport tb_omon(clocking cb_omon);

/*property p1;
@(posedge clk)
disable iff(rst)
!rst->!($isunknown(rdata));
endproperty

a1:assert property(p1)
$display("assertion pass");
else
$display("assertion fail");*/


endinterface
