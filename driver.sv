class driver;
packet pkt;
mailbox#(packet)mbx;
virtual ram_if.tb_driver rif;
bit[15:0]pkt_c;

//custom constructor
function new(input mailbox#(packet)inp_mbx,input virtual ram_if.tb_driver aif);
mbx=inp_mbx;
rif=aif;
endfunction

task run();
forever begin
mbx.get(pkt);
$display ("reset applied to dut");
rif.rst<=0;
rif.rst<=1;
@(rif.cb_driver)
rif.rst<=0;
$display ("reset completed");

rif.cb_driver.wr<=0;
rif.cb_driver.wdata<=pkt.wdata;
rif.cb_driver.addr<=pkt.addr;
@(rif.cb_driver)
@(rif.cb_driver)

rif.cb_driver.wr<=1;
rif.cb_driver.addr<=pkt.addr;
@(rif.cb_driver)
@(rif.cb_driver)
pkt_c++;
$display("[DRI]%0d  wdata=%0d addr=%0d time=%0t",pkt_c,pkt.wdata,pkt.addr,$time);
end
endtask
endclass
