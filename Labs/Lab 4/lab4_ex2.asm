;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 4, ex 2
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================

.orig x3000
	
	LD R1, POINTER
	LD R2, COUNTER
	AND R3, R3, #0
	
	LOOP
		STR R3, R1, #0		;Store Value into address at R1
		ADD R3, R3, #1		;Increment value
		ADD R1, R1, #1		;Increment address
		ADD R2, R2, #-1		;Decrement Counter
		BRp LOOP
	END_LOOP
	
	LD R1, POINTER			;Reset R1 to point to front of array
	LDR R2, R1, #6			;Get the 6th value from front into R2
	
	LD R2, COUNTER			;Reset Counter
	
	LOOP_2
		LDR R0, R1, #0		;Load the memory in address R1
		ADD R1, R1, #1		;Increment the address
		ADD R0, R0, #15		;Turn into ascii +48
		ADD R0, R0, #15		
		ADD R0, R0, #15
		ADD R0, R0, #3
		OUT					;print
		ADD R2, R2, #-1		;Decrement Counter
		BRp LOOP_2
	END_LOOP_2
	

HALT
	POINTER .FILL x4000
	COUNTER .FILL #10
	.orig x4000
	.BLKW #10

.end
