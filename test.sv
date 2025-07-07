class test;
environment env;
bit [15:0] pkt_c;

virtual ram_if.tb_driver aif; // driver
virtual ram_if.tb_imon imif; //imon
virtual ram_if.tb_omon omif;

function new(input virtual ram_if.tb_driver eif, input virtual ram_if.tb_imon IMIF,input virtual ram_if.tb_omon OMIF);
aif=eif;
imif=IMIF;
omif=OMIF;
endfunction

//buid
function void build();
pkt_c=10;
env=new(aif,imif,omif,pkt_c);
env.build();
endfunction

task run();
build();
env.run();
endtask
endclass
