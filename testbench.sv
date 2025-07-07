program testbench(ram_if rif);
test test_a1;

initial begin;
test_a1=new(rif.tb_driver,rif.tb_imon,rif.tb_omon);
test_a1.run();
end
endprogram