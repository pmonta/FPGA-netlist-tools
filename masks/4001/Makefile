include ../rules.make

all: 4001.gds 4001.cif 4001.svg 4001.spice

PNGS = contact.png diffusion.png metal.png poly.png
NAME = 4001
# scale (in microns per pixel) of the png files (must be a multiple of 0.002):
SCALE = 1.480

4001.svg: contact.vec.svg diffusion.vec.svg metal.vec.svg poly.vec.svg
	../tools/make-composite-svg.py 2712 1768 >4001.svg

4001.cif: $(PNGS) pads.txt
	../tools/png2cif.py $(NAME) $(SCALE) >4001.cif

4001.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >4001.gds

clean:
	rm -f $(PNGS) *.cif *.gds *~
	rm -f 4001.spice 4001.ext 4001.feedback
	rm -f magic.log magic.log2
	rm -f ext2spice.log ext2spice.log2
	rm -f *.vec.svg
	rm -f 4001.svg
