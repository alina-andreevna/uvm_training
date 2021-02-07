if [file exists work] {vdel -all}
vlib work
vlog -f uvm_example/scripts/compile.f
vsim -voptargs="+acc" top +UVM_TESTNAME=verbose_test
run -all