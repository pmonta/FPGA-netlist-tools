all: 4002.gds 4002.cif

PNGS = contact.png diffusion.png metal.png poly.png
NAME = 4002
SCALE = 1.0

4002.cif: $(PNGS)
	../tools/png2cif.py $(NAME) $(SCALE) >4002.cif

4002.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >4002.gds

%.png: %.bmp
	<$< bmptoppm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pnmtopng >$@

clean:
	rm -f *.png *.cif *.gds *~
