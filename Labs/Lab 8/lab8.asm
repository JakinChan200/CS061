;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 8, ex 1 & 2
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================

; test harness
					.orig x3000
	LD R6, SUB_PRINT_OPCODE_TABLE
	JSRR R6
	
	LD R6, SUB_FIND_OPCODE
	JSRR R6
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
	TEST_VALUE				.FILL #2
	SUB_PRINT_OPCODE_TABLE  .FILL x3200
	SUB_FIND_OPCODE			.FILL x3600

;===============================================================================================


; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE_TABLE
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;				 and corresponding opcode in the following format:
;					ADD = 0001
;					AND = 0101
;					BR = 0000
;					…
; Return Value: None
;-----------------------------------------------------------------------------------------------
		.orig x3200
;Backup affected Registers
	ST R0, backup_r0_3200
	ST R1, backup_r1_3200				
	ST R2, backup_r2_3200
	ST R3, backup_r3_3200
	ST R6, backup_r6_3200
	ST R7, backup_r7_3200		 
;-------------------------------
;Subroutine Algorithmn
;-------------------------------
	LD R1, opcodes_po_ptr
	LD R3, instructions_po_ptr
	LOOP_1
		PRINT_OPCODE
			LDR R0, R3, #0
			BRz END_PRINT_OPCODE
			BRn END_LOOP_1
			OUT
			ADD R3, R3, #1
			BR PRINT_OPCODE
		END_PRINT_OPCODE
		ADD R3, R3, #1
		
		LEA R0, EQUALS
		PUTS
		
		LDR R2, R1, #0
		LD R6, SUB_PRINT_OPCODE
		JSRR R6
		ADD R1, R1, #1
		
		LD R0, NEWLINE
		OUT
		
		BR LOOP_1
	END_LOOP_1	 
				 
				 
;Restore backed up registers
	LD R0, backup_r0_3200
	LD R1, backup_r1_3200				 
	LD R2, backup_r2_3200
	LD R3, backup_r3_3200
	LD R6, backup_r6_3200
	LD R7, backup_r7_3200
;Return
	ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE_TABLE local data
opcodes_po_ptr		.fill x4000				; local pointer to remote table of opcodes
instructions_po_ptr	.fill x4100				; local pointer to remote table of instructions
	SUB_PRINT_OPCODE .FILL x3400
	NEWLINE			 .FILL '\n'
	EQUALS 			 .STRINGZ " = "
	backup_r0_3200 	 .BLKW #1
	backup_r1_3200 	 .BLKW #1
	backup_r2_3200	 .BLKW #1
	backup_r3_3200	 .BLKW #1
	backup_r6_3200	 .BLKW #1
	backup_r7_3200	 .BLKW #1

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
	.orig x3400
;Backup affected Registers
	ST R0, backup_r0_3400
	ST R1, backup_r1_3400				
	ST R2, backup_r2_3400
	ST R3, backup_r3_3400
	ST R4, backup_r4_3400
	ST R5, backup_r5_3400
	ST R7, backup_r7_3400		 
;-------------------------------
;Subroutine Algorithmn
;-------------------------------
	LD R3, BIT_MASK
	LD R1, COUNTER
	NOT R5, R3				;Create Negative of Bit Mask
	ADD R5, R5, #1
	LOOP
		AND R4, R2, R3		;Bit Mask the greatest Digit
		ADD R2, R2, R2		;Left-Shift
		ADD R4, R5, R4		;Check if greatest Digit is a 1
		BRnp NOT_ONE
			LD R0, ONE		;Set R0 to print 1
			BR WAS_ONE
		NOT_ONE
			LD R0, ZERO		;Set R0 to print 0
		WAS_ONE
		OUT
		ADD R1, R1, #-1		;Decrement Counter
		BRp LOOP
	END_LOOP
				 
;Restore backed up registers
	LD R0, backup_r0_3400
	LD R1, backup_r1_3400				 
	LD R2, backup_r2_3400
	LD R3, backup_r3_3400
	LD R4, backup_r4_3400
	LD R5, backup_r5_3400
	LD R7, backup_r7_3400
;Return
	ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data
		backup_r0_3400 	.BLKW #1
		backup_r1_3400 	.BLKW #1
		backup_r2_3400	.BLKW #1
		backup_r3_3400	.BLKW #1
		backup_r4_3400	.BLKW #1
		backup_r5_3400	.BLKW #1
		backup_r7_3400	.BLKW #1
		BIT_MASK		.FILL x8
		COUNTER 		.FILL #4
		ZERO			.FILL #48
		ONE				.FILL #49
;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3600
;Backup affected Registers
	ST R0, backup_r0_3600
	ST R1, backup_r1_3600				
	ST R2, backup_r2_3600
	ST R3, backup_r3_3600
	ST R4, backup_r4_3600
	ST R5, backup_r5_3600
	ST R6, backup_r6_3600
	ST R7, backup_r7_3600		 
;-------------------------------
;Subroutine Algorithmn
;-------------------------------
	MAIN_LOOP
		LD R2, INPUT_POINTER
		LD R6, 	SUB_GET_STRING
		JSRR R6
				 
		LD R1, opcodes_fo_ptr
		LD R2, instructions_fo_ptr
		
		LD R3, INPUT_POINTER
		
		AND R4, R4, #0
		CHECK_EACH_CHAR
			LDR R5, R3, #0
			LDR R0, R2, #0
			ADD R0, R5, R0
			BRz END_CHECK_EACH_CHAR
			LDR R0, R2, #0
			CHECK_IF_END
				ADD R5, R5, #0
				BRz SKIP_INCREMENT
					ADD R3, R3, #1
				SKIP_INCREMENT
				ADD R0, R0, #0
				BRz END_CHECK_IF_END
				ADD R2, R2, #1
			END_CHECK_IF_END
			NOT R0, R0
			ADD R0, R0, #1
			ADD R0, R0, R5
			BRz IS_VALID
				ADD R4, R4, #1
			IS_VALID
			BR CHECK_EACH_CHAR
		END_CHECK_EACH_CHAR
		
		
		ADD R4, R4, #0
		BRz PRINT_
		LD R3, INPUT_POINTER
		ADD R2, R2, #1
		LDR R0, R2, #0
		ADD R0, R0, #0
		BRn PRINT_INVALID
		AND R4, R4, #0
		ADD R1, R1, #1
		BR CHECK_EACH_CHAR
		
		PRINT_INVALID
			LEA R0, INVALID
			PUTS
			BR MAIN_LOOP
			
		PRINT_
			LD R0, INPUT_POINTER
			PUTS	
			LEA R0, EQUALS_1
			PUTS
			LDR R2, R1, #0
			LD R6, SUB_PRINT_OPCODE_1
			JSRR R6
			LEA R0, NEWLINE_1
			PUTS
			BR MAIN_LOOP
	END_MAIN_LOOP	 
;Restore backed up registers
	LD R0, backup_r0_3600
	LD R1, backup_r1_3600				 
	LD R2, backup_r2_3600
	LD R3, backup_r3_3600
	LD R4, backup_r4_3600
	LD R5, backup_r5_3600
	LD R6, backup_r6_3600
	LD R7, backup_r7_3600
;Return
	ret
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
	opcodes_fo_ptr			.fill x4000
	instructions_fo_ptr		.fill x4100
	SUB_GET_STRING			.FILL x3800
	SUB_PRINT_OPCODE_1		.FILL x3400
	INVALID				.STRINGZ "Invalid Instruction\n"
	EQUALS_1			.STRINGZ " = "
	NEWLINE_1			.STRINGZ "\n"
	INPUT_POINTER		.FILL x4200
	backup_r0_3600 	.BLKW #1
	backup_r1_3600 	.BLKW #1
	backup_r2_3600	.BLKW #1
	backup_r3_3600	.BLKW #1
	backup_r4_3600	.BLKW #1
	backup_r5_3600	.BLKW #1
	backup_r6_3600	.BLKW #1
	backup_r7_3600	.BLKW #1
	.orig x4200
	INPUT .BLKW #100

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
					.orig x3800
;Backup affected Registers
	ST R0, backup_r0_3800
	ST R1, backup_r1_3800				
	ST R2, backup_r2_3800
	ST R7, backup_r7_3800
;-------------------------------
;Subroutine Algorithmn
;-------------------------------			 
	LEA R0, PROMPT
	PUTS
	
	GET_STRING_LOOP
		GETC
		OUT
		
		ADD R1, R0, #-10
		BRz END_GET_STRING_LOOP
		
		STR R0, R2, #0
		ADD R2, R2, #1
		
		BR GET_STRING_LOOP
	END_GET_STRING_LOOP
	AND R0, R0, #0
	STR R0, R2, #0
	
;Restore backed up registers				 
	LD R0, backup_r0_3800
	LD R1, backup_r1_3800				 
	LD R2, backup_r2_3800
	LD R7, backup_r7_3800				 
;Return				 
	ret
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data
	PROMPT			.STRINGZ "Enter an instruction, followed by ENTER\n"
	backup_r0_3800 	.BLKW #1
	backup_r1_3800 	.BLKW #1
	backup_r2_3800	.BLKW #1
	backup_r7_3800	.BLKW #1

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
					.ORIG x4000			; list opcodes as numbers from #0 through #15, e.g. .fill #12 or .fill xC
					.FILL x0
					.FILL x1
					.FILL x2
					.FILL x3
					.FILL x4
					.FILL x5
					.FILL x6
					.FILL x7
					.FILL x8
					.FILL x9
					.FILL xA
					.FILL xB
					.FILL xC
					.FILL xD
					.FILL xE
					.FILL xF
; opcodes


					.ORIG x4100			; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
								 		; - be sure to follow same order in opcode & instruction arrays!
					.STRINGZ "BR"
					.STRINGZ "ADD"
					.STRINGZ "LD"		;2
					.STRINGZ "ST"
					.STRINGZ "JSR"		;4
					.STRINGZ "AND"
					.STRINGZ "LDR"		;6
					.STRINGZ "STR"
					.STRINGZ "RTI"		;8
					.STRINGZ "NOT"
					.STRINGZ "LDI"		;10
					.STRINGZ "STI"
					.STRINGZ "RET"		;12
					.STRINGZ "RESERVED"
					.STRINGZ "LEA"		;14
					.STRINGZ "TRAP"		;15
					.FILL 	 #-1		;-1
; instructions	

;===============================================================================================
