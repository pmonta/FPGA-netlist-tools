all: 6502.cif 6502.gds 6502.spice

PNGS = buried.png contact.png diffusion.png metal.png poly.png implant.png
NAME = 6502
#SCALE = 0.94
SCALE = 2

sim: 6502-run.spice 6502-system.spice 6502.spice
	ngspice --batch 6502-run.spice

nodes.txt: 6502Node-subsplits.svg
	./polygon2label.py <6502Node-subsplits.svg >nodes.txt

6502.cif: $(PNGS) nodes.txt
	../tools/png2cif.py $(NAME) $(SCALE) >6502.cif

6502.gds: $(PNGS)
	../tools/png2gds.py $(NAME) $(SCALE) >6502.gds

.PRECIOUS: %.ext

%.spice: %.ext
	ext2spice $* >ext2spice.log 2>ext2spice.log2
	./mark_new_depletion.py <$*.spice >temp.spice
	mv temp.spice $*.spice

%.ext: %.cif
	echo 'cif read 6502.cif' >magic.script
	echo 'extract' >>magic.script
	echo 'quit -noprompt' >>magic.script
	magic -T nmos -dnull -noconsole <magic.script >magic.log 2>magic.log2
	rm -f magic.script
	rm -f \(UNNAMED\).ext

%.png: %.polygon
	<$< ../tools/polygon2png.py
	<out.png pngtopnm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pnmtopng >$@
	rm -f out.png

implant.polygon: pullups.js
	./make_implant_polygons.py <pullups.js >implant.polygon

clean:
	rm -f *.png *.cif *.gds *.ext *~
	rm -f 6502.spice
	rm -f magic.log magic.log2
	rm -f ext2spice.log ext2spice.log2
	rm -f nodes.txt
	rm -f 6502-spice-rawfile.raw
	rm -f implant.polygon
