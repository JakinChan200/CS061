;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 5, ex 3
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================
.orig x3000
	LD R6, READ_SUBROUTINE_3200
	JSRR R6
	
	LD R6, PRINT_SUBROUTINE_3400
	JSRR R6
	
HALT
	READ_SUBROUTINE_3200  .FILL x3200
	PRINT_SUBROUTINE_3400 .FILL x3400
	
;=======================================================================
; Subroutine: READ_SUBROUTINE_3200
; Parameter: R6, contains address of binary pattern to print
; Postcondition: Prints what is contained in the address in binary
; Return Value: No return value
;=======================================================================
	.orig x3200

;Backup affected Registers
	ST R0, backup_r0_1
	ST R1, backup_r1_1
	ST R3, backup_r3_1
	ST R7, backup_r7_1

;-------------------------------
;Subroutine Algorithmn
;-------------------------------
	AND R2, R2, #0
	LD R1, COUNTER_16
	AND R4, R4, #0
	
	CHECK_B
	LEA R0, ENTER_NUM
	PUTS
	GETC
	OUT
	ADD R3, R0, #-15
	ADD R3, R3, #-15
	ADD R3, R3, #-15
	ADD R3, R3, #-15
	ADD R3, R3, #-15
	ADD R3, R3, #-15
	ADD R3, R3, #-8
	BRz GET_USER_INPUT
	LEA R0, ERROR_MSG
	PUTS
	BR CHECK_B
	
	GET_USER_INPUT
		GETC
		OUT
		ADD R3, R0, #-15
		ADD R3, R3, #-15
		ADD R3, R3, #-2
		BRnp END_SPACE_ENTERED
		SPACE_ENTERED
			BR GET_USER_INPUT
		END_SPACE_ENTERED
		ADD R3, R3, #-15
		ADD R3, R3, #-1
		BRz ZERO_NUMBER
		ADD R3, R3, #-1
		BRz VALID_NUMBER
			BR GET_USER_INPUT
		VALID_NUMBER
		ADD R2, R2, #1
		ZERO_NUMBER
		ADD R1, R1, #-1
		BRz END_GET_USER_INPUT
		ADD R2, R2, R2
		BR GET_USER_INPUT
	END_GET_USER_INPUT
	
	LD R0, NEWLINE_1
	OUT

;Restore backed up registers
	LD R0, backup_r0_1
	LD R1, backup_r1_1
	LD R3, backup_r3_1
	LD R7, backup_r7_1

;Return
	ret
	
	COUNTER_16 .FILL #16
	ENTER_NUM .STRINGZ "Enter b followed by 16 bit binary\n"
	ERROR_MSG .STRINGZ "\nValue entered not valid\n"
	NEWLINE_1 .FILL #10

backup_r0_1	.BLKW #1
backup_r1_1	.BLKW #1
backup_r3_1	.BLKW #1
backup_r7_1	.BLKW #1
;=======================================================================
; Subroutine: PRINT_SUBROUTINE_3200
; Parameter: None
; Postcondition: Reads "b", followed by 16 1s and 0s
; Return Value: R2, contains binary number of what is read
;=======================================================================
	.orig x3400
;========================
; Subroutine Instructions
;========================
;Backup affected Registers
	ST R0, backup_r0
	ST R1, backup_r1
	;ST R2, backup_r2
	ST R3, backup_r3
	ST R4, backup_r4
	ST R5, backup_r5
	ST R6, backup_r6
	ST R7, backup_r7
;-------------------------------
;Subroutine Algorithmn
;-------------------------------

;LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
ADD R1, R2, #0			; R1 <-- value to be displayed as binary 

	LD R2, COUNTER_1
	LD R4, BIT_MASK
	LD R5, SPACE_COUNTER
	LOOP_1
		AND R3, R1,	R4
		BRz ZERO_DIGIT
			LD R0, ONE_1
			OUT
			BR END_ZERO_DIGIT
		ZERO_DIGIT
			LD R0, ZERO
			OUT
		END_ZERO_DIGIT
		ADD R1, R1, R1
		
		ADD R6, R2, #-1
		BRz END_LOOP_1
		
		ADD R5, R5, #-1
		BRp NO_SPACEBAR
			LD R0, SPACE
			OUT
			LD R5, SPACE_COUNTER
		NO_SPACEBAR
		ADD R2, R2, #-1
		BRp LOOP_1
	END_LOOP_1
	
	LD R0, NEWLINE
	OUT
;Restore backed up registers
	LD R0, backup_r0
	LD R1, backup_r1
	;LD R2, backup_r2
	LD R3, backup_r3
	LD R4, backup_r4
	LD R5, backup_r5
	LD R6, backup_r6
	LD R7, backup_r7

;Return
	ret
;---------------	
;Local Data for subroutine
;---------------
	COUNTER_1 	.FILL #16
	SPACE_COUNTER .FILL #4
	SPACE 		.FILL #32
	ONE_1 		.FILL #49
	ZERO 		.FILL #48
	NEWLINE 	.FILL #10
	BIT_MASK 	.FILL x8000
	backup_r0	.BLKW #1
	backup_r1	.BLKW #1
	backup_r2	.BLKW #1
	backup_r3	.BLKW #1
	backup_r4	.BLKW #1
	backup_r5	.BLKW #1
	backup_r6	.BLKW #1
	backup_r7	.BLKW #1

.end
