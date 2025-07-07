vlib work
vlog top.sv
vsim -assertdebug top +acc
add wave -r *
run -all
coverage report -detail