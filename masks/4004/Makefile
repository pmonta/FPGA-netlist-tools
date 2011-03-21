include ../rules.make

all: 4004.gds 4004.cif 4004.spice

PNGS = buried.png contact.png diffusion.png metal.png poly.png
NAME = 4004
SCALE = 1.2

4004.cif: $(PNGS) pads.txt
	../tools/png2cif.py $(NAME) $(SCALE) >4004.cif

4004.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >4004.gds

clean:
	rm -f $(PNGS) *.cif *.gds *~
	rm -f 4004.spice 4004.ext 4004.feedback
	rm -f magic.log magic.log2
	rm -f ext2spice.log ext2spice.log2
