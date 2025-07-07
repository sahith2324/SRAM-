//environment :encapsulation of all components, build and connect

class environment;
//variables

bit [15:0] pkt_c;
// mailbox mbx, mbx=new()
mailbox #(packet) top_mbx; // gen to drv
mailbox #(packet) imon_scb; // imon to scb
mailbox #(packet) omon_scb; // omon to scb
mailbox #(packet) imon_cov;//imon to cvg


virtual ram_if.tb_driver eif; // driver
virtual ram_if.tb_imon mif; //imon
virtual ram_if.tb_omon mof; //omon
// gen=new
generator gen;
driver drv;
imonitor imon;
omonitor omon;
scoreboard scb;
coverage cov;

// custom construct(env interact with dut,once virtual connection)

function new(input virtual ram_if.tb_driver inp_eif,input virtual ram_if.tb_imon inp_mif,input virtual ram_if.tb_omon out_mof,input bit [15:0] cnt);

eif=inp_eif;
mif=inp_mif;
mof=out_mof;
pkt_c=cnt;

endfunction

// build components and connect

function void build();
top_mbx=new();
imon_scb=new();
omon_scb=new();
imon_cov=new();

gen=new(top_mbx,pkt_c);
drv=new(top_mbx,eif);
imon=new(mif,imon_scb,imon_cov);
omon=new(mof,omon_scb);
scb=new(imon_scb,omon_scb);
cov=new(imon_cov);

endfunction

// run task
task run();
gen.run();

fork
drv.run();
imon.run();
cov.run();
omon.run();
scb.run();
wait(pkt_c==scb.pkt_c); //condition that must be checked
//(test termination criteria)
join_any

// DRAIN TIME
repeat(10)@(eif.cb_driver);// just to settle down all the output keeping some extra clk
result();

endtask

function void result();
bit [15:0] total_pkt_cnt;
total_pkt_cnt=scb.matched+scb.mismatched;

if((scb.mismatched==0)&&(scb.matched==pkt_c)&&(pkt_c==total_pkt_cnt))
begin
$display("TEST PASS");
$display("[info] packet count=%0d matched=%0d mismatched=%0d",pkt_c,scb.matched,scb.mismatched);
$display("[cov] coverage score=%2.2f ",cov.cov_scr);

end

else
begin
$display("TEST FAIL");
$display("[ERR] packet count=%0d matched=%0d mismatched=%0d",pkt_c,scb.matched,scb.mismatched);
$display("[cov] coverage score=%2.2f ",cov.cov_scr);
end
endfunction
endclass