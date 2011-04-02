include ../rules.make

all: 4003.gds 4003.cif 4003.svg 4003.spice

PNGS = contact.png diffusion.png metal.png poly.png
NAME = 4003
# scale (in microns per pixel) of the png files (must be a multiple of 0.002):
SCALE = 0.830

4003.svg: contact.vec.svg diffusion.vec.svg metal.vec.svg poly.vec.svg
	../tools/make-composite-svg.py 23280 14560 >4003.svg

4003.cif: $(PNGS) pads.txt
	../tools/png2cif.py $(NAME) $(SCALE) >4003.cif

4003.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >4003.gds

extract: 4003.spice
	<4003.spice ../tools/spice-reduce.py >4003-reduced.spice
	python ./translate.py

clean:
	rm -f $(PNGS) *.cif *.gds *~
	rm -f 4003.spice 4003.ext 4003.feedback
	rm -f magic.log magic.log2
	rm -f ext2spice.log ext2spice.log2
	rm -f *.vec.svg
	rm -f 4003.svg
