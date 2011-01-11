	*= $fff0
start:	lda #$34
	sta $d012
loop:	jmp loop

	*= $fffc
	!16 start
