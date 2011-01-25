#all: 6502.cif 6502.gds
all: 6502.gds

PNGS = buried.png contact.png diffusion.png metal.png poly.png

6502.cif: $(PNGS)
	../tools/png2cif.py >6502.cif

6502.gds: $(PNGS)
	../tools/png2gds.py >6502.gds

%.png: %.polygon
	<$< ../tools/polygon2png.py
	<out.png pngtopnm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pnmtopng >$@
	rm -f out.png

clean:
	rm -f *.png *.cif *.gds *~
