;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 9, ex 3
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================

; test harness
					.orig x3000
	MAIN_LOOP
		LD R5, MAX
		LD R3, offset
		LD R4, BASE
		LD R6, BASE
		
		LEA R0, VALUE_PROMPT
		PUTS
		GETC
		OUT
		ADD R0, R0, R3
		LD R2, SUB_STACK_PUSH
		JSRR R2
		LD R0, newline
		OUT
		
		LEA R0, VALUE_PROMPT
		PUTS
		GETC
		OUT
		ADD R0, R0, R3
		LD R2, SUB_STACK_PUSH
		JSRR R2
		LD R0, newline
		OUT
		
		LEA R0, MULTIPLY_PROMPT
		PUTS
		GETC
		OUT
		LD R2, SUB_STACK_PUSH
		JSRR R2
		LD R0, newline
		OUT
		
		LD R2, SUB_RPN_MULTIPLY
		JSRR R2
		
		LEA R0, RESULT_PROMPT
		PUTS
		LD R2, SUB_STACK_POP
		JSRR R2
		ADD R1, R0, #0
		LD R2, PRINT_DECIMAL
		JSRR R2
				 
	END_MAIN_LOOP		 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
newline				.FILL 	'\n'
VALUE_PROMPT		.STRINGZ "Enter in a value you want to multiply\n"
MULTIPLY_PROMPT		.STRINGZ "Enter the multiplication symbol\n"
RESULT_PROMPT		.STRINGZ "The result is: "
offset					.FILL #-48
MAX						.FILL xA005
BASE					.FILL xA000
SUB_STACK_PUSH			.FILL x3200
SUB_STACK_POP			.FILL x3400
SUB_RPN_MULTIPLY		.FILL x3600
PRINT_DECIMAL			.FILL x3800
;===============================================================================================


; subroutines:

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH_3200
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3200
;Backup registers
	ST R0, backup_r0_3200
	ST R1, backup_r1_3200
	ST R2, backup_r2_3200
	ST R3, backup_r3_3200
	ST R4, backup_r4_3200
	ST R5, backup_r5_3200
	ST R7, backup_r7_3200 
		 
	NOT R5, R5
	ADD R5, R5, #1
	ADD R1, R5, R6
	BRn UNDER_STACK
		LEA R0, OVERFLOW_MESSAGE
		PUTS
		BR END_OF_SUB
	UNDER_STACK
	ADD R6, R6, #1
	STR R0, R6, #0	 
	END_OF_SUB
				 
;Restore registers
	LD R0, backup_r0_3200
	LD R1, backup_r1_3200
	LD R2, backup_r2_3200
	LD R3, backup_r3_3200
	LD R4, backup_r4_3200
	LD R5, backup_r5_3200
	LD R7, backup_r7_3200			 			 
				 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data
	backup_r0_3200 	.BLKW #1
	backup_r1_3200 	.BLKW #1
	backup_r2_3200 	.BLKW #1
	backup_r3_3200 	.BLKW #1
	backup_r4_3200 	.BLKW #1
	backup_r5_3200 	.BLKW #1
	backup_r7_3200 	.BLKW #1
	OVERFLOW_MESSAGE  .STRINGZ "\nOverflow Error"


;===============================================================================================


;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP_3400
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3400
;Backup registers
	ST R1, backup_r1_3400
	ST R2, backup_r2_3400
	ST R3, backup_r3_3400
	ST R4, backup_r4_3400
	ST R5, backup_r5_3400
	ST R7, backup_r7_3400 
	
	NOT R4, R4
	ADD R4, R4, #1
	
	ADD R1, R4, R6
	BRp NOT_UNDERFLOW
		LEA R0, UNDERFLOW_MESSAGE
		PUTS
		BR END_OF_SUB_3400
	NOT_UNDERFLOW
	LDR R0, R6, #0
	ADD R6, R6, #-1
	END_OF_SUB_3400
				 
;Restore registers
	LD R1, backup_r1_3400
	LD R2, backup_r2_3400
	LD R3, backup_r3_3400
	LD R4, backup_r4_3400
	LD R5, backup_r5_3400
	LD R7, backup_r7_3400	
					ret
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data
	backup_r1_3400 	.BLKW #1
	backup_r2_3400 	.BLKW #1
	backup_r3_3400 	.BLKW #1
	backup_r4_3400 	.BLKW #1
	backup_r5_3400 	.BLKW #1
	backup_r7_3400 	.BLKW #1
	UNDERFLOW_MESSAGE .STRINGZ "\nUnderflow Error"

;===============================================================================================

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    multiplied them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R6 ← updated TOS address
;------------------------------------------------------------------------------------------
					.orig x3600
;Backup registers
	ST R1, backup_r1_3600
	ST R2, backup_r2_3600
	ST R3, backup_r3_3600
	ST R4, backup_r4_3600
	ST R5, backup_r5_3600
	ST R7, backup_r7_3600 	 		 
	
	LD R0, SUB_STACK_POP_3400
	JSRR R0

	LD R0, SUB_STACK_POP_3400
	JSRR R0
	ADD R1, R0, #0
	
	LD R0, SUB_STACK_POP_3400
	JSRR R0
	ADD R2, R0, #0
	
	AND R0, R0, #0
	MULTIPLICATION_LOOP
		ADD R0, R0, R1
		ADD R2, R2, #-1
		BRp MULTIPLICATION_LOOP
	END_MULTIPLICATION_LOOP

	LD R2, SUB_STACK_PUSH_3200
	JSRR R2
	
;Restore registers
	LD R1, backup_r1_3600
	LD R2, backup_r2_3600
	LD R3, backup_r3_3600
	LD R4, backup_r4_3600
	LD R5, backup_r5_3600
	LD R7, backup_r7_3600				 		 
					ret
;-----------------------------------------------------------------------------------------------
; SUB_RPN_MULTIPLY local data
	backup_r1_3600 	.BLKW #1
	backup_r2_3600 	.BLKW #1
	backup_r3_3600 	.BLKW #1
	backup_r4_3600 	.BLKW #1
	backup_r5_3600 	.BLKW #1
	backup_r7_3600 	.BLKW #1
	SUB_STACK_POP_3400 .FILL x3400
	SUB_STACK_PUSH_3200 .FILL x3200
	offset_1		.FILL #-48

;===============================================================================================



; SUB_MULTIPLY		

; SUB_GET_NUM		

; SUB_PRINT_DECIMAL		Only needs to be able to print 1 or 2 digit numbers. 
;						You can use your lab 7 s/r.

;-----------------------------------------------------------------------
; Subroutine: PRINT_DECIMAL_3800
; Parameter(R1): The number to convert to decimal
; Postcondition: The subroutine will print the random hardcoded value
;-----------------------------------------------------------------------
	.orig x3800
;========================
; Subroutine Instructions
;========================
;Backup affected Registers
	ST R0, backup_r0_3800
	ST R1, backup_r1_3800
	ST R2, backup_r2_3800
	ST R3, backup_r3_3800
	ST R4, backup_r4_3800
	ST R5, backup_r5_3800
	ST R6, backup_r6_3800
	ST R7, backup_r7_3800
;-------------------------------
;Subroutine Algorithmn
;-------------------------------
	AND R2, R2, #0
	LD R6, OFFSET
	ADD R1, R1, #0					;Print negative sign if negative
	BRzp NOT_NEGATIVE
		LEA R0, minus
		PUTS
		NOT R1, R1
		ADD R1, R1, #1
	NOT_NEGATIVE
	
	AND R5, R5, #0					;Set NumToPrint to 0
	LOOP_10000
		LD R3, VAR_10000			;Get negative of digit
		NOT R3, R3
		ADD R3, R3, #1
		
		ADD R5, R5, #1				;Increase Counter
		ADD R1, R3, R1				;Subtract Digit
		BRp LOOP_10000				;Go subtract again if you can
		
		LD R4, VAR_10000			;Revert Number back to positive
		ADD R1, R1, R4
		ADD R5, R5, #-1				;Decrememnt Counter by 1
		BRp START_PRINT_10000		;Check if leading 0
			ADD R2, R2, #0
			BRz SKIP_PRINT_10000
		START_PRINT_10000			;Print if not leading 0
		ADD R2, R2, #1
		ADD R0, R5, R6
		OUT
		
	SKIP_PRINT_10000
	AND R5, R5, #0
	LOOP_1000
		LD R3, VAR_1000
		NOT R3, R3
		ADD R3, R3, #1
		
		ADD R5, R5, #1
		ADD R1, R3, R1
		BRp LOOP_1000
		
		LD R4, VAR_1000
		ADD R1, R1, R4
		ADD R5, R5, #-1
		BRp START_PRINT_1000
			ADD R2, R2, #0
			BRz SKIP_PRINT_1000
		START_PRINT_1000
		ADD R2, R2, #1
		ADD R0, R5, R6
		OUT

	SKIP_PRINT_1000
	AND R5, R5, #0
	LOOP_100
		LD R3, VAR_100
		NOT R3, R3
		ADD R3, R3, #1
		
		ADD R5, R5, #1
		ADD R1, R3, R1
		BRp LOOP_100
		
		LD R4, VAR_100
		ADD R1, R1, R4
		ADD R5, R5, #-1
		BRp START_PRINT_100
			ADD R2, R2, #0
			BRz SKIP_PRINT_100
		START_PRINT_100
		ADD R2, R2, #1
		ADD R0, R5, R6
		OUT

	SKIP_PRINT_100
	AND R5, R5, #0
	LOOP_10
		AND R3, R3, #0
		ADD R3, R3, #-10
		
		ADD R5, R5, #1
		ADD R1, R3, R1
		BRp LOOP_10
		
		ADD R1, R1, #10
		ADD R5, R5, #-1
		BRp START_PRINT_10
			ADD R2, R2, #0
			BRz SKIP_PRINT_10
		START_PRINT_10
		ADD R2, R2, #1
		ADD R0, R5, R6
		OUT

	SKIP_PRINT_10
		ADD R0, R1, R6
		OUT
		
		LEA R0, NEWLINE
		PUTS
;Restore backed up registers
	LD R0, backup_r0_3800
	LD R1, backup_r1_3800
	LD R2, backup_r2_3800
	LD R3, backup_r3_3800
	LD R4, backup_r4_3800
	LD R5, backup_r5_3800
	LD R6, backup_r6_3800
	LD R7, backup_r7_3800
;Return
	ret
;---------------	
;Local Data for subroutine
;---------------
	minus			.STRINGZ "-"
	NEWLINE			.STRINGZ "\n"
	OFFSET			.FILL #48
	VAR_10000		.FILL #10000
	VAR_1000		.FILL #1000
	VAR_100			.FILL #100
	backup_r0_3800	.BLKW #1
	backup_r1_3800	.BLKW #1
	backup_r2_3800	.BLKW #1
	backup_r3_3800	.BLKW #1
	backup_r4_3800	.BLKW #1
	backup_r5_3800	.BLKW #1
	backup_r6_3800	.BLKW #1
	backup_r7_3800	.BLKW #1
