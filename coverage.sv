class coverage;
packet pkt;
mailbox #(packet)mbx_cov;
real cov_scr;

//coverage
covergroup cov with function sample(packet pkt);//we are writing this as we dont any other values than what is randomised in the packet
//inputs of imonitor only will be the coverpoints of the coverage .
x: coverpoint pkt.wdata {
                    bins b={ [4:200]};}

y:coverpoint pkt.addr {
                    bins b1={0,1,2,3,5,6,7};}
					

    
endgroup

//custom constructor
function new(input mailbox #(packet) inp_mbx_cov);
mbx_cov=inp_mbx_cov;
cov=new;  //embbeded way of writing so we can just give new to thw covergroup name so it is created.
endfunction

//run task
task run;
forever begin

mbx_cov.get(pkt);
// read the sample values
cov.sample(pkt);
cov_scr=cov.get_coverage();
$display("[cov] coverage value=%2.2f",cov_scr);
end
endtask
endclass