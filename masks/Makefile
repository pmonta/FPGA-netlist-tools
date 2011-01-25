all: 6502.cif 6502.gds

PNGS = buried.png contact.png diffusion.png metal.png poly.png

6502.cif: $(PNGS)
	./png2cif.py >6502.cif

6502.gds: $(PNGS)
	./png2gds.py >6502.gds

%.png: %.polygon
	<$< ./polygon2png.py
	<out.png pngtopnm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pnmtopng >$@
	rm -f out.png

clean:
	rm -f *.png *.cif *.gds *~
