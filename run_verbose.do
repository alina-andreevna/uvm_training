if [file exists "work"] {vdel -all -lib work}
if ![file exists "rpt"] {mkdir rpt}

vlib work
vlog -f compile.f -l rpt/vlog.log
vsim -novopt -voptargs="+acc" tb +UVM_TESTNAME=tst_start -l rpt/vsim.log
do sim/tests/wfs/dut.do
run 500ns