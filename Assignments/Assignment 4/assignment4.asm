;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 22
; TA: Jason Zellmer
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R1
;=================================================================================

					.ORIG x3000		
;-------------
;Instructions
;-------------
	LOOP
; output intro prompt
		LD R0, introPromptPtr
		PUTS
						
; Set up flags, counters, accumulators as needed
		AND R2, R2, #0
		AND R1, R1, #0
		AND R6, R6, #0
		LD R5, COUNTER_5
; Get first character, test for '\n', '+', '-', digit/non-digit 	
					; is very first character = '\n'? if so, just quit (no message)!
		GETC
		OUT
		ADD R3, R0, #-10
		BRz END_LOOP
					; is it = '+'? if so, ignore it, go get digits
		ADD R3, R3, #-15
		ADD R3, R3, #-15
		ADD R3, R3, #-3
			BRnp NOT_POSITIVE_SIGN
				GETC
				OUT
				ADD R6, R6, #1
				BR LOOP_2
			NOT_POSITIVE_SIGN
					; is it = '-'? if so, set neg flag, go get digits
		ADD R3, R3, #-2
		BRnp NOT_NEGATIVE
			GETC
			OUT
			ADD R2, R2, #1
		NOT_NEGATIVE
		ADD R6, R6, #1
		
		LOOP_2
			ADD R6, R6, #0
			BRp SKIP_GETC
				GETC
				OUT
			SKIP_GETC
			AND R6, R6, #0
			ADD R3, R0, #0
			ADD R3, R3, #-10
			BRz TEST_NEGATIVE
			ADD R3, R3, #-5
			ADD R3, R3, #-15
			ADD R3, R3, #-15
			ADD R3, R3, #-3
					; is it < '0'? if so, it is not a digit	- o/p error message, start over
			BRzp NOT_INVALID_INPUT_1
				LD R0, NEWLINE
				OUT
				LD R0, errorMessagePtr
				PUTS
				BR LOOP
			NOT_INVALID_INPUT_1
						; is it > '9'? if so, it is not a digit	- o/p error message, start over
			ADD R3, R3, #-9
			BRnz NOT_INVALID_INPUT_2
				LD R0, NEWLINE
				OUT
				LD R0, errorMessagePtr
				PUTS
				BR LOOP
			NOT_INVALID_INPUT_2
						; if none of the above, first character is first numeric digit - convert it to number & store in target register!
			ADD R0, R0, #-15
			ADD R0, R0, #-15
			ADD R0, R0, #-15
			ADD R0, R0, #-3
			ADD R3, R1, #0
			LD R4, COUNTER
			MULTIPLY_BY_TEN
				ADD R1, R3, R1
				ADD R4, R4, #-1
				BRp MULTIPLY_BY_TEN
			END_MULTIPLY_BY_TEN
			ADD R1, R0, R1
			ADD R5, R5, #-1
			BRp LOOP_2
		END_LOOP_2
		LD R0, NEWLINE
		OUT
		
		TEST_NEGATIVE
		ADD R2, R2, #0
		BRnz NO_NEGATIVE_SIGN
			NOT R1, R1
			ADD R1, R1, #1
		NO_NEGATIVE_SIGN
; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator
					; remember to end with a newline!
	END_LOOP
					
					HALT

;---------------	
; Program Data
;---------------

introPromptPtr		.FILL xB000
errorMessagePtr		.FILL xB200
COUNTER				.FILL #9
COUNTER_5			.FILL #5
NEWLINE				.FILL #10

;------------
; Remote data
;------------
					.ORIG xB000			; intro prompt
					.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
					.ORIG xB200			; error message
					.STRINGZ	"ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
					.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
