;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 22
; TA: Jason Zellmer
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
	LD R2, COUNTER
	LD R4, BIT_MASK
	LD R5, SPACE_COUNTER
	LOOP
		AND R3, R1,	R4
		BRz ZERO_DIGIT
			LD R0, ONE
			OUT
			BR END_ZERO_DIGIT
		ZERO_DIGIT
			LD R0, ZERO
			OUT
		END_ZERO_DIGIT
		ADD R1, R1, R1
		
		ADD R6, R2, #-1
		BRz END_LOOP
		
		ADD R5, R5, #-1
		BRp NO_SPACEBAR
			LD R0, SPACE
			OUT
			LD R5, SPACE_COUNTER
		NO_SPACEBAR
		ADD R2, R2, #-1
		BRp LOOP
	END_LOOP
	
	LD R0, NEWLINE
	OUT
	

HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xCB00	; The address where value to be displayed is stored
COUNTER 	.FILL #16
SPACE_COUNTER .FILL #4
SPACE 		.FILL #32
ONE 		.FILL #49
ZERO 		.FILL #48
NEWLINE 	.FILL #10
BIT_MASK 	.FILL x8000

.ORIG xCB00					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
