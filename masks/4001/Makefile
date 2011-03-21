include ../rules.make

all: 4001.gds 4001.cif 4001.spice

PNGS = contact.png diffusion.png metal.png poly.png
NAME = 4001
SCALE = 1.2

4001.cif: $(PNGS) pads.txt
	../tools/png2cif.py $(NAME) $(SCALE) >4001.cif

4001.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >4001.gds

clean:
	rm -f $(PNGS) *.cif *.gds *~
	rm -f 4001.spice 4001.ext 4001.feedback
	rm -f magic.log magic.log2
	rm -f ext2spice.log ext2spice.log2
