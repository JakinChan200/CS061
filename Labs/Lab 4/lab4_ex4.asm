;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 4, ex 4
; Lab section: 22
; TA: jason Zellmer
; 
;=================================================

.orig x3000
	
	LD R1, POINTER			
	LD R2, COUNTER
	LD R3, ONE
	
	LOOP
		STR R3, R1, #0			;Store value into address in R1
		ADD R3, R3, R3			;Double Value
		ADD R1, R1, #1			;Increment address
		ADD R2, R2, #-1			;Decrement counter
		BRp LOOP
	END_LOOP
	
	LD R1, POINTER				;Reset R1 to point to head of array
	LDR R2, R1, #6				;Get 6th value from head and put in R2
	LD R2, COUNTER				;Reset Counter
	
	LOOP_2
		LDR R0, R1, #0			;Load value into R0
		OUT						;Print
		ADD R1, R1, #1			;Increment address
		ADD R2, R2, #-1			;Decrement counter
		BRp LOOP_2
	END_LOOP_2

HALT
	POINTER .FILL x4000
	COUNTER .FILL #10
	ONE		.FILL x1
	.orig x4000
	.BLKW #10

.end
