;=================================================
; Name: Jakin Chan
; Email:  jchan419@ucr.edu
; 
; Lab: lab 2, ex 2
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================

.orig x3000
	LDI R3, DEC_65_PTR      ;Load R3 with the value at x4000
	LDI R4, HEX_41_PTR		;Load R4 with the value at x4001
	
	ADD R3, R3, #1
	ADD R4, R4, #1	

	STI R3, DEC_65_PTR      ;Store the value of R3 into x4000
	STI R4, HEX_41_PTR		;Store the value of R4 into x4001
	
HALT
	
	DEC_65_PTR .FILL x4000  ;Fill DEC_65_PTR with the address x4000
	HEX_41_PTR .FILL x4001	;Make HEX_41_PTR with the address x4001
	
			.orig x4000
	.FILL #65               ;Fill address 4000 with #65
	.FILL x41				;Fill address 4001 with x41

.end
