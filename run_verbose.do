vlib work
vlog -f compile.f
vsim -novopt -voptargs="+acc" tb_top_fir_lowpass +UVM_TESTNAME=verbose_test
run -all