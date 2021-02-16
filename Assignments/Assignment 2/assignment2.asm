;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
GETC					;Get first number and print it
OUT
ADD R1, R0, #0
LD R0, newline    		;Make a Newline
OUT
GETC					;Get second number and print it
OUT
ADD R2, R0, #0
LD R0, newline			;Make a newline
OUT

ADD R0, R1, #0			;Print first number
OUT
LEA R0, middle			;Print " - "
PUTS		
ADD R0, R2, #0			;Print second Number
OUT
LEA R0, equals			;Print " = "
PUTS

NOT R2, R2				;Flips second number to negative and adds them
ADD R2, R2, #1
ADD R1, R1, R2

BRp POSITIVE
BRz POSITIVE
LEA R0, minus			;Prints the negative sign
PUTS

NOT R1, R1				;Flips the answer back to positive
ADD R1, R1, #1

POSITIVE				;Prints the ascii equivalent
	ADD R0, R1, #0
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #3
	OUT
	
	LD R0, newline			;Make a newline
	OUT

HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
middle  .STRINGZ    " - "
equals  .STRINGZ    " = "
minus   .STRINGZ    "-"
newline .FILL '\n'	; newline character - use with LD followed by OUT

;---------------	
;END of PROGRAM
;---------------	
.END
