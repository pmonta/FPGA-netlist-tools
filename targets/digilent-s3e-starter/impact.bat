setmode -bscan
setcable -p auto
identify
assignFile -p 1 -file chip.bit
program -p 1
quit 
