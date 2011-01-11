DEVICE=xc3s500e-4fgg320c

all:
	echo "run -ifn chip.v -ifmt Verilog -top system -ofn chip -p ${DEVICE}" | xst
	ngdbuild -p ${DEVICE} -uc chip.ucf chip
	map -w -timing -p ${DEVICE} chip.ngd chip.pcf
	par -w chip.ncd chip.ncd chip.pcf
#	bitgen -g StartupClk:JtagClk -w chip.ncd chip.bit chip.pcf

clean:
	rm -rf xst _xmsgs xlnx_auto_0_xdb
	rm -f *.bld *.map *.mrp *.ngc *.ngd *.ngm *.ncd *.pad *.par *.pcf *.ptwx *.unroutes *.xpi *.xrpt *.csv *.txt *.xml *.lst *.html