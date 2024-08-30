.org 0x08000000

b SetThumbMode

.space 188

SetThumbMode:
	adr r0, Main
	add r0, r0, #1
	bx r0			;Sets code to Thumb mode

	.thumb
Main:
	ldr r0, DisplayAddress
	ldr r1, Mode3BG2
	str r1, [r0,#0]		;Sets display mode to Mode 3 on BG2
	
	ldr r0, VRAMAddress
	ldr r1, Colour
	ldr r2, CanvasSizeDiv3	;Stores the VRAM address and colour to write
	
DrawLoop:
	strh r1,[r0,#0]		;Writes the colour to the VRAM address
	add r0, r0, #6		;Moves 3 pixels forward
	sub r2, r2, #1		;Minus one from the canvas counter
	bne DrawLoop
	
Infinite:
	b Infinite
	
	.align 4
DisplayAddress:
	.long 0x4000000		;The first I/O register
	
VRAMAddress:
	.long 0x6000000		;The start of VRAM
	
Mode3BG2:
	.int 0x0403		;The I/O command to set Mode 3
	
Colour:
	.long 0x7AFB		;The colour to display
	
CanvasSizeDiv3:
	.long 0x3200		;The canvas counter divided by 3