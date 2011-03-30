include ../rules.make

all: 6800.cif 6800.gds 6800.spice

PNGS = buried.png contact.png diffusion.png metal.png poly.png
NAME = 6800
# scale (in microns per pixel) of the png files (must be a multiple of 0.002):
SCALE = 1.000

6800.cif: $(PNGS)
	../tools/png2cif.py $(NAME) $(SCALE) >6800.cif

6800.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >6800.gds

clean:
	rm -f $(PNGS) *.cif *.gds *.ext *~
	rm -f 6800.spice 6800.ext 6800.feedback
	rm -f magic.log magic.log2
	rm -f ext2spice.log ext2spice.log2
