include ../rules.make

all: 4004.gds 4004.cif 4004.svg 4004.spice lajos-4004.spice translate

PNGS = buried.png contact.png diffusion.png metal.png poly.png
NAME = 4004
# scale (in microns per pixel) of the png files (must be a multiple of 0.002):
SCALE = 1.450

4004.svg: buried.vec.svg contact.vec.svg diffusion.vec.svg metal.vec.svg poly.vec.svg
	../tools/make-composite-svg.py 1968 2706 >4004.svg

sim: 4004-run.spice 4004-system.spice 4004.spice
	ngspice --batch 4004-run.spice

4004.cif: $(PNGS) nodes.txt pads.txt
	../tools/png2cif.py $(NAME) $(SCALE) >4004.cif

nodes.txt: i4004-signals.txt
	../tools/lajos2nodes.py <i4004-signals.txt >nodes.txt

4004.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >4004.gds

translate: 4004.spice
	<4004.spice ../tools/spice-reduce.py >4004-reduced.spice
	PYTHONPATH=../../netlist-translation python ./translate.py

lajos-4004.spice: lajos-4004-layout-netlist.txt
	../tools/lajos2spice.py <lajos-4004-layout-netlist.txt >lajos-4004.spice

clean:
	rm -f $(PNGS) *.cif *.gds *~
	rm -f 4004.spice 4004.ext 4004.feedback
	rm -f magic.log magic.log2
	rm -f ext2spice.log ext2spice.log2
	rm -f nodes.txt
	rm -f lajos-4004.spice
	rm -f 4004-reduced.spice
	rm -f *.vec.svg
	rm -f 4004.svg
