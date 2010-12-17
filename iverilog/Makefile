VSRC = ../verilog/{test_6502.v,chip_6502.v,clocks_6502.v,ram_6502.v,spice.v,spice_node.v}

test_allasm:
	iverilog -DW=6 -DMAXTICKS=10000000 -DDISPLAY_WRITES -DCODE=\"../6502-test-code/AllSuiteA.bin\" -DCODE_START=4000 -DRESET=4000 -I../verilog $(VSRC)
2.v,clocks_6502.v,ram_6502.v,spice.v,spice_node.v}

test1:
	iverilog -DW=6 -DMAXTICKS=80000 -DDISPLAY_WRITES -DCODE=\"../6502-test-code/test1.bin\" -DCODE_START=FFF0 -DRESET=FFF0 -I../verilog $(VSRC)
