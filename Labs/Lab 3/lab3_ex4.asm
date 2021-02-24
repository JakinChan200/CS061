;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================
.orig x3000
	LEA R0, INTRO
	PUTS
	
	LD R2, ARRAY
	
	;LD R0, newline			;print newline
	;OUT
	
	LOOP
		GETC					;Get user input and print it
		OUT
		STR R0, R2, #0		    ;Store user input at address in R2
		
		ADD R2, R2, #1			;Increment the address
		ADD	R1, R0, #-10		;Check if entered value is ascii #10
		BRnp LOOP
	END_LOOP

	LD R2, ARRAY
	
	LOOP_2
		LDR R0, R2, #0			;Get stored value
		OUT
		ADD R2, R2, #1			;Increment by 1
		ADD R1, R2, #-10		;check if is ascii #10
		BRnp LOOP_2				;Loop if no
	END_LOOP_2
	
	LD R0, newline				;print newline
	OUT
	
HALT
	INTRO .STRINGZ "Enter 10 Characters: \n"
	newline .FILL '\n'	
	
	ARRAY .FILL x4000
		.orig x4000
	.BLKW #100
.end
