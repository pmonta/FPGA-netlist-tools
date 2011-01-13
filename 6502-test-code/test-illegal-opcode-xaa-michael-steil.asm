	*= $ffe0
start:	lda #$00  ; a9 00
	!8 $a2
	!8 $ff
	!8 $8b
	!8 $ff
	sta $0180 ; 8d 80 01
loop:	jmp loop

	*= $fffc
	!16 start
