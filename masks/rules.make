.PRECIOUS: %.ext

%.spice: %.ext
	ext2spice $* >ext2spice.log 2>ext2spice.log2
	../tools/fix_spice_comments.py <$*.spice >temp1.spice
	bash -c 'if [ -f ./mark_new_depletion.py ]; then (./mark_new_depletion.py <temp1.spice >temp2.spice); else mv temp1.spice temp2.spice; fi'
	rm -f temp1.spice
	mv temp2.spice $*.spice

%.ext: %.cif
	echo 'scalegrid 1 2000' >magic.script
	echo 'snap internal' >>magic.script
	echo -n 'cif read ' >>magic.script
	echo '$<' >>magic.script
	echo 'extract' >>magic.script
	echo -n 'feedback save ' >>magic.script
	echo '$*.feedback' >>magic.script
	echo 'quit -noprompt' >>magic.script
	magic -T nmos -dnull -noconsole <magic.script >magic.log 2>magic.log2
	rm -f magic.script
	rm -f \(UNNAMED\).ext

%.png: %.polygon
	bash -c 'if [ -f $*.tweak ]; then (./apply-tweak.py $*.tweak <$< >temp.polygon); else cp $< temp.polygon; fi'
	<temp.polygon ../tools/polygon2png.py 4000 4000
	<out.png pngtopnm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pnmtopng >$@
	rm -f temp.polygon out.png

%.png: %.bmp
#	pbmmake -white 3 3 >t3.pbm
#	<$< bmptoppm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pamenlarge 3 | pgmmorphconv -dilate t3.pbm | pnmtopng >$@
#	rm -f t3.pbm
	<$< bmptoppm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pnmtopng >$@
