all: netlist.v

netlist.txt: pins.txt metal.png diffusion.png contact.png gate.png implant.png
	./masks_to_netlist.py pins.txt metal.png diffusion.png contact.png gate.png implant.png >netlist.txt

netlist.v: netlist.txt
	./netlist_to_verilog.py <netlist.txt >netlist.v

sim: testbench.v netlist.v
	iverilog testbench.v netlist.v
	./a.out

clean:
	rm -f netlist.txt netlist.v a.out *~
