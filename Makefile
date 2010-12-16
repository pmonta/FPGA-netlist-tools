VSRC = test_6502.v chip_6502.v clocks_6502.v ram_6502.v spice.v spice_node.v
VINCLUDE = common.h

sim: $(VSRC) $(VINCLUDE)
	iverilog -Wimplicit $(VSRC)
	verilator --public --cc top.v --top-module main --exe sim_main.cpp

chip_6502.v: analyze.py netlist_javascript.py netlist.py util.py
	./analyze.py /home/pmonta/visual6502

spice_node.v: gen_spice_node.py
	python ./gen_spice_node.py >spice_node.v

view:
	gtkwave test_6502.lxt test_6502.sav
