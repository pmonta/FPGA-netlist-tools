all: 4001.gds 4001.cif

PNGS = contact.png diffusion.png metal.png poly.png
NAME = 4001
SCALE = 1.0

4001.cif: $(PNGS)
	../tools/png2cif.py $(NAME) $(SCALE) >4001.cif

4001.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >4001.gds

%.png: %.bmp
	<$< bmptoppm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pnmtopng >$@

clean:
	rm -f *.png *.cif *.gds *~
