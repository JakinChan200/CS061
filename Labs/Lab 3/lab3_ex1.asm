;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================

.orig x3000
	LD R5, DATA_PTR		;Load the pointer to x4000 address into R5
	ADD R6, R5, #1
	
	LDR R3, R5, #0		;Load the R5 values into R3, with 0 offset
	LDR R4, R6, #0		;Load the R6 values into R4, with 0 offset
	
	ADD R3, R3, #1		;increment
	ADD R4, R4, #1		;increment
	
	STR R3, R5, #0		;Stores values from R3 into where R5 points to
	STR R4, R6, #0		;Stores values from R4 into where R6 points to
	
HALT

	DATA_PTR .FILL x4000	;Fill DATA_PTR with the x4000 address
	
		.orig x4000
	.FILL #65
	.FILL x41
.end
