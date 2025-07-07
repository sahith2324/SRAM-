class generator;
// properties/variables
packet  pkt,ref_pkt;
//parameterizied mailbox, restricted data type
mailbox #(packet) mbx;
bit [15:0] pkt_count,pkt_c;
	
//custom constructor--this is for mailbox creation
function new(input mailbox #(packet) inp_mbx,input bit [15:0] cnt);
mbx=inp_mbx;
pkt_count=cnt;
ref_pkt=new();
endfunction

//main logic of generator
task run();
repeat(pkt_count)
begin
assert(ref_pkt.randomize())
$display("[gen] random value generated");
else
$display("[gen] random values failed to generate");
pkt_c++;
pkt=new ref_pkt;
mbx.put(pkt);
$display("[gen]%0d  wdata=%0d addr=%0d time=%0t",pkt_c,pkt.wdata,pkt.addr,$time);
end
 endtask
 
 endclass