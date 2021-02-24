;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 3, ex 2
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================

.orig x3000
	LEA R0, INTRO
	PUTS
	
	LD R1, COUNTER
	LEA R2, ARRAY
	
	LOOP
		GETC					;Get user input and print it
		OUT
		STR R0, R2, #0			;Store user input at address in R2
		
		LD R0, newline			;print newline
		OUT
		
		ADD R2, R2, #1			;Increment the address
		ADD R1, R1, #-1			;Decrement the counter
		BRp LOOP
	END_LOOP

HALT
	INTRO .STRINGZ "Enter 10 Characters: \n"
	newline .FILL '\n'
	COUNTER .FILL #10
	ARRAY .BLKW #10
.end
