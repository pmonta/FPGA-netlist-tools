include ../rules.make

all: 4002.gds 4002.cif 4002.svg 4002.spice

PNGS = contact.png diffusion.png metal.png poly.png
NAME = 4002
# scale (in microns per pixel) of the png files (must be a multiple of 0.002):
SCALE = 1.270

4002.svg: contact.vec.svg diffusion.vec.svg metal.vec.svg poly.vec.svg
	../tools/make-composite-svg.py 2176 2552 >4002.svg

4002.cif: $(PNGS) pads.txt
	../tools/png2cif.py $(NAME) $(SCALE) >4002.cif

4002.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >4002.gds

clean:
	rm -f $(PNGS) *.cif *.gds *~
	rm -f 4002.spice 4002.ext 4002.feedback
	rm -f magic.log magic.log2
	rm -f ext2spice.log ext2spice.log2
	rm -f *.vec.svg
	rm -f 4002.svg
