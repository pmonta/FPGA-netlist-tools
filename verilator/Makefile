sim:
#	verilator -DDISPLAY_WRITES --cc ../verilog/top.v --top-module main -I../verilog --exe sim_main.cpp
	verilator --cc ../verilog/top.v --top-module main -I../verilog --exe sim_main.cpp
	(cd obj_dir ; make -f Vmain.mk )

run_monitor:
	(cd obj_dir ; ./Vmain -code ../../6502-test-code/apple1monitor.bin -code_start 65280)

run_basic:
	(cd obj_dir ; ./Vmain -code ../../6502-test-code/apple1basic.bin -code_start 57344 -reset_vector 57344)
