//imonitor block
class imonitor;
packet pkt;
virtual ram_if.tb_imon rif;
mailbox#(packet)mbx;
mailbox #(packet)mbx_cov;
bit[15:0]pkt_c;

function new(input virtual ram_if.tb_imon aif,input mailbox#(packet)inp_mbx,input mailbox #(packet) inp_mbx_cov);
rif=aif;
mbx=inp_mbx;
mbx_cov=inp_mbx_cov;
endfunction

task run();
forever begin
@(rif.cb_imon.wdata or rif.cb_imon.addr);
pkt_c++;
pkt=new();
pkt.wdata=rif.cb_imon.wdata;
pkt.addr=rif.cb_imon.addr;
mbx.put(pkt);
mbx_cov.put(pkt);

$display("[IMON] detected%0d wdata=%0d addr=%0d time=%0t",pkt_c,rif.cb_imon.wdata,rif.cb_imon.addr,$time);
end 
endtask
endclass