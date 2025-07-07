class omonitor;
packet pkt; // null pointer
virtual ram_if.tb_omon rif;
mailbox #(packet) mbx;
bit [15:0] pkt_c;

//custom constructor
function new(input virtual ram_if.tb_omon aif,input mailbox #(packet) inp_mbx);
rif=aif;
mbx=inp_mbx;
endfunction

//actual code
task run();
forever begin
@(rif.cb_omon.rdata);
pkt_c++;
pkt=new();
pkt.rdata=rif.cb_omon.rdata;
mbx.put(pkt);
$display("[OMON] detected%0d rdata=%0d at time=%0t",pkt_c,rif.cb_omon.rdata,$time);
end
endtask
endclass