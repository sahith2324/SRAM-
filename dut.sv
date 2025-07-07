//ram DUT
module ram_dut(clk,rst,wr,wdata,rdata,addr);
input clk,rst,wr; // 2 bit inputs
input[7:0]wdata;
input[3:0]addr;
output reg[7:0]rdata;
reg[7:0]mem[0:15];

always@(posedge clk or posedge rst)
begin
    if(rst)
       for(int i=0;i<16;i++)
          mem[i]<=8'b0;
     else
     begin
       if (wr==0)
          mem[addr]<=wdata;
       else if(wr==1)
         rdata<=mem[addr];
    end 
  end
endmodule
