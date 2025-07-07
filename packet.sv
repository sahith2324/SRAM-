class packet;
 rand bit[7:0]wdata;
 randc bit[3:0]addr;
 bit[7:0]rdata;
 bit [7:0] pre_wdata;
 bit [3:0] pre_addr;
 
 
 
 
 constraint valid1{
 addr inside {[0:12]};
 }
 
  constraint valid2{
 wdata inside {[0:200]};
 }
 
 /*constraint valid3{
 wdata!=pre_wdata;
 addr!=pre_addr;
 }*/

function void post_randomize();
pre_wdata=wdata;
pre_addr=addr;
endfunction

endclass