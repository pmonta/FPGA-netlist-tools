sim:
	verilator -DW=6 -DHALFCYCLE=90 --cc ../verilog/top.v --top-module main -I../verilog --exe sim_main.cpp
#	(cd obj_dir ; make -f Vmain.mk )
	(cd obj_dir ; make OPT_FAST="-O2" -f Vmain.mk )

run_monitor:
	(cd obj_dir ; ./Vmain -code ../../6502-test-code/apple1monitor.bin -code_start 65280)

run_basic:
	(cd obj_dir ; ./Vmain -code ../../6502-test-code/apple1basic.bin -code_start 57344 -reset_vector 57344)

clean:
	rm -rf obj_dir
