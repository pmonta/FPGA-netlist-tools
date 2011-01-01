VSRC = ../verilog/{test_6502.v,chip_6502.v,clocks_6502.v,ram_6502.v,models.v}
VFLAGS = -Wall

test_allasm:
	iverilog $(VFLAGS) -DW=6 -DMAXTICKS=10000000 -DHALFCYCLE=70 -DDISPLAY_WRITES -DCODE=\"../6502-test-code/AllSuiteA.bin\" -DCODE_START=4000 -DRESET=4000 -I../verilog $(VSRC)

test1:
	iverilog $(VFLAGS) -DW=6 -DMAXTICKS=80000 -DHALFCYCLE=70 -DDISPLAY_WRITES -DCODE=\"../6502-test-code/test1.bin\" -DCODE_START=FFF0 -DRESET=FFF0 -I../verilog $(VSRC)

clean:
	rm -f a.out *.lxt
