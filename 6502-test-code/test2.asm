	*= $0000
start:	lda #$34
loop:	sta $58
	adc #$03
	jmp loop
