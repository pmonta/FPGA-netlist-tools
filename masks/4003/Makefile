include ../rules.make

all: 4003.gds 4003.cif 4003.spice

PNGS = contact.png diffusion.png metal.png poly.png
NAME = 4003
SCALE = 0.7

4003.cif: $(PNGS) pads.txt
	../tools/png2cif.py $(NAME) $(SCALE) >4003.cif

4003.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >4003.gds

clean:
	rm -f *.png *.cif *.gds *~
	rm -f 4003.spice 4003.ext
	rm -f magic.log magic.log2
	rm -f ext2spice.log ext2spice.log2
