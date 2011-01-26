all: 4004.gds 4004.cif

PNGS = buried.png contact.png diffusion.png metal.png poly.png
NAME = 4004
SCALE = 1.6

4004.cif: $(PNGS)
	../tools/png2cif.py $(NAME) $(SCALE) >4004.cif

4004.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >4004.gds

%.png: %.bmp
	<$< bmptoppm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pnmtopng >$@

clean:
	rm -f *.png *.cif *.gds *~
