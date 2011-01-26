all: 4003.gds 4003.cif

PNGS = contact.png diffusion.png metal.png poly.png
NAME = 4003
SCALE = 0.7

4003.cif: $(PNGS)
	../tools/png2cif.py $(NAME) $(SCALE) >4003.cif

4003.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >4003.gds

%.png: %.bmp
	<$< bmptoppm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pnmtopng >$@

clean:
	rm -f *.png *.cif *.gds *~
