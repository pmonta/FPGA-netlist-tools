DEVICE=xc3s500e-4vq100

all:
	echo "run -ifn chip.v -ifmt Verilog -top godil40_xc3s500e -ofn chip -p ${DEVICE}" | xst
	ngdbuild -p ${DEVICE} -uc chip.ucf chip
	map -w -timing -detail -ol high -p ${DEVICE} chip.ngd chip.pcf
	par -w -ol high chip.ncd chip.ncd chip.pcf
	trce -v 20 chip.ncd chip.pcf
	bitgen -g StartupClk:JtagClk -g GTS_cycle:3 -g LCK_cycle:4 -g GWE_cycle:5 -g DONE_cycle:6 -w chip.ncd chip.bit chip.pcf
	promgen -w -spi -p mcs -u 0 chip.bit

clean:
	rm -rf xst _xmsgs xlnx_auto_0_xdb
	rm -f *~
	rm -f *.bgn *.bld *.drc *.map *.mrp *.ncd *.ngc *.ngd *.ngm *.pad *.par *.pcf *.ptwx *.unroutes *.xpi
	rm -f *.cfi *.prm
	rm -f _impact.cmd _impact.log
	rm -f *_bitgen.xwbt *_ngdbuild.xrpt *_pad.csv *_pad.txt *_summary.xml *_usage.xml
	rm -f *_xst.xrpt *_map.xrpt *_par.xrpt
	rm -f _impactbatch.log netlist.lst usage_statistics_webtalk.html webtalk.log
