.PRECIOUS: %.ext

%.spice: %.ext
	ext2spice $* >ext2spice.log 2>ext2spice.log2
	../tools/fix_spice_comments.py <$*.spice >temp1.spice
	bash -c 'if [ -f ./mark_new_depletion.py ]; then (./mark_new_depletion.py <temp1.spice >temp2.spice); else mv temp1.spice temp2.spice; fi'
	mv temp2.spice $*.spice

%.ext: %.cif
	echo -n 'cif read ' >magic.script
	echo '$<' >>magic.script
	echo 'extract' >>magic.script
	echo 'quit -noprompt' >>magic.script
	magic -T nmos -dnull -noconsole <magic.script >magic.log 2>magic.log2
	rm -f magic.script
	rm -f \(UNNAMED\).ext

%.png: %.polygon
	<$< ../tools/polygon2png.py
	<out.png pngtopnm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pnmtopng >$@
	rm -f out.png

%.png: %.bmp
	pbmmake -white 3 3 >t3.pbm
	<$< bmptoppm | ppmtopgm | pamthreshold -simple -threshold=0.5 | pamenlarge 3 | pgmmorphconv -dilate t3.pbm | pnmtopng >$@
	rm -f t3.pbm
