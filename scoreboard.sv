//scoreboard block
class scoreboard;
packet exp_pkt;
packet recv_packet;

mailbox#(packet)imon_mbox;
mailbox#(packet)omon_mbox;

bit [15:0] pkt_c;
bit[ 15:0] matched,mismatched;


function new(input mailbox#(packet)inp_mbox,input mailbox#(packet)out_mbox);
imon_mbox=inp_mbox;
omon_mbox=out_mbox;
endfunction


	//actual logic
	task run();
	forever begin
	imon_mbox.get(exp_pkt);
	omon_mbox.get(recv_packet);
	pkt_c++;

   if(exp_pkt.wdata==recv_packet.rdata)begin
   matched++;
   $display("[SCB_info] pkt_c=%0d outputs matched  exp= %0d recv=%0d   time=%0t",pkt_c,exp_pkt.wdata,recv_packet.rdata,$time);
   end
   else begin
   mismatched++;
     $display("[SCB_error] pkt_c=%0d outputs mismatched  exp= %0d recv=%0d   time =%0t",pkt_c,exp_pkt.wdata,recv_packet.rdata,$time);
  end
   end
   endtask
   endclass