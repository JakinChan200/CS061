;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 2, ex 3
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================

.orig x3000
	LD R5, DEC_65		;Load the pointer to x4000 address into R5
	LD R6, HEX_41		;Load the pointer to x4001 address into R6
	
	LDR R3, R5, #0		;Load the R5 values into R3, with 0 offset
	LDR R4, R6, #0		;Load the R6 values into R4, with 0 offset
	
	ADD R3, R3, #1		;increment
	ADD R4, R4, #1		;increment
	
	STR R3, R5, #0		;Stores values from R3 into where R5 points to
	STR R4, R6, #0		;Stores values from R4 into where R6 points to
	
HALT

	DEC_65 .FILL x4000	;Fill DEC_65 with the x4000 address
	HEX_41 .FILL x4001	;Fill HEX_41 with the x4001 address
	
		.orig x4000
	.FILL #65
	.FILL x41
.end
