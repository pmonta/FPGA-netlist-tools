VSRC = ../../verilog/{test_4004.v,chip_4004.v,clocks_4004.v,models.v,rom_4004.v}
VFLAGS = -Wall

test:
	iverilog $(VFLAGS) -DW=6 -DMAXTICKS=10000000 -DQUARTERCYCLE=250 -I../../verilog $(VSRC)
	./a.out -lxt2

clean:
	rm -f a.out *.lxt
