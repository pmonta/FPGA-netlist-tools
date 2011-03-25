include ../rules.make

all: 4004.gds 4004.cif 4004.spice

PNGS = buried.png contact.png diffusion.png metal.png poly.png
NAME = 4004
# scale (in microns per pixel) of the png files (must be a multiple of 0.002):
SCALE = 1.450

#%.png: %.bmp
#	pbmmake -white 3 3 >t3.pbm
#	<$< bmptoppm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pamenlarge 3 | pgmmorphconv -dilate t3.pbm | pnmtopng >$@
#	rm -f t3.pbm

#contact.png: contact.bmp
#	pbmmake -white 3 3 >t3.pbm
#	<$< bmptoppm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pgmmorphconv -dilate t3.pbm | pnmtopng >$@
#	rm -f t3.pbm

4004.cif: $(PNGS) nodes.txt pads.txt
	../tools/png2cif.py $(NAME) $(SCALE) >4004.cif

nodes.txt: i4004-signals.txt
	../tools/lajos2nodes.py <i4004-signals.txt >nodes.txt

4004.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >4004.gds

extract: 4004.spice
	<4004.spice ../tools/spice-reduce.py >4004-reduced.spice
#	python ./translate.py

clean:
	rm -f $(PNGS) *.cif *.gds *~
	rm -f 4004.spice 4004.ext 4004.feedback
	rm -f magic.log magic.log2
	rm -f ext2spice.log ext2spice.log2
