;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 1, ex 0
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================
.orig x3000
	;--------
	; Instructions
	;--------
		LEA R0, MSG_TO_PRINT ;R0 <-- the location of the label; MSG_TO_PRINT
		PUTS                 ;Prints string defined at MSG_TO_PRINT
		
		HALT                 ;terminate program
	;--------
	;Local data
	;--------
		MSG_TO_PRINT .STRINGZ  "Hello world!!!\n"  ;strong 'H' in an address labelled
												  ;MSG_TO_PRINT and then each
												  ;character ('e', 'l', 'l', ...) in
												  ;its own (consecutive) memory
												  ;address, followed by #0 at the end
												  ;of the string to mark the end of the
												  ;string
.end
