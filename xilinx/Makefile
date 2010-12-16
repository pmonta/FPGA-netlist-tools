#DEVICE=xc6slx75-3fgg484
DEVICE=xc6slx150-2fgg484

all:
	echo "run -ifn chip.v -ifmt Verilog -top chip_6502 -ofn chip -p ${DEVICE}" | xst
##	ngdbuild -p ${DEVICE} -uc chip.ucf chip
	ngdbuild -p ${DEVICE} chip
	map -p ${DEVICE} chip.ngd chip.pcf
	par -w chip.ncd chip.ncd chip.pcf
##	bitgen -g StartupClk:JtagClk -w chip.ncd chip.bit chip.pcf

clean:
	rm -rf xst _xmsgs
