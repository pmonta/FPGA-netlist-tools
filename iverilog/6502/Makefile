VSRC = ../../verilog/{test_6502.v,chip_6502.v,clocks_6502.v,ram_6502.v,models.v}
VFLAGS = -Wall

test_allasm:
	iverilog $(VFLAGS) -DW=6 -DMAXTICKS=10000000 -DHALFCYCLE=25 -DDISPLAY_WRITES -DCODE=\"../../6502-test-code/AllSuiteA.bin\" -DCODE_START=4000 -DRESET=4000 -I../../verilog $(VSRC)

test1:
	iverilog $(VFLAGS) -DW=6 -DMAXTICKS=80000 -DHALFCYCLE=25 -DDISPLAY_WRITES -DCODE=\"../../6502-test-code/test1.bin\" -DCODE_START=FFF0 -DRESET=FFF0 -I../../verilog $(VSRC)

test-illegal-opcode-xaa-michael-steil:
	iverilog $(VFLAGS) -DW=6 -DMAXTICKS=50000 -DHALFCYCLE=25 -DDISPLAY_WRITES -DCODE=\"../../6502-test-code/test-illegal-opcode-xaa-michael-steil.bin\" -DCODE_START=FFE0 -DRESET=FFE0 -I../../verilog $(VSRC)
	./a.out -lxt2
	gtkwave test_6502.lxt

clean:
	rm -f a.out *.lxt
