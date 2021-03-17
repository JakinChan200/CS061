;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 6, ex 3
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================
.orig x3000
	LD R1, START_ADDRESS
	LD R6, SUB_GET_STRING_3200
	JSRR R6
	
	ADD R0, R1, #0
	PUTS
	
	LD R6, SUB_IS_PALINDROME_3400
	JSRR R6
	
	ADD R4, R4, #0
	BRp IS_PALINDROME
		LEA R0, IS_NOT_A_PALINDROME
		PUTS
		BR END_IS_PALINDROME
	IS_PALINDROME
		LEA R0, IS_A_PALINDROME
		PUTS
	END_IS_PALINDROME
	
HALT
	SUB_GET_STRING_3200    .FILL x3200
	SUB_IS_PALINDROME_3400 .FILL x3400
	IS_A_PALINDROME			.STRINGZ " IS a palindrome\n"
	IS_NOT_A_PALINDROME 	.STRINGZ " IS NOT a palindrome\n"
	START_ADDRESS .FILL x4000
		.orig x4000
	ADDRESS	.BLKW #100
;=======================================================================
; Subroutine: SUB_GET_STRING_3200
; Parameter: (R1) The starting address of the character arraay
; Postcondition: The subroutine has prompter the user to input a string.
;				terminated by the [ENTER] key (the "sentinel"), and has stored
;				the received characters in an array of characters starting at (R1).
;				the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value: (R5), The nuumber of non-sentinel characters read from user
;				(R1), the starting address of array
;=======================================================================
	.orig x3200
;========================
; Subroutine Instructions
;========================
;Backup affected Registers
	ST R0, backup_r0
	ST R1, backup_r1
	ST R2, backup_r2
	ST R3, backup_r3
	ST R4, backup_r4
	;ST R5, backup_r5
	ST R6, backup_r6
	ST R7, backup_r7
;-------------------------------
;Subroutine Algorithmn
;-------------------------------
	LEA R0, ENTER_CHARS
	PUTS
	AND R5, R5, #0
	ADD R2, R1, #0
	LD R4, ZERO
	
	LOOP
		GETC
		OUT
		ADD R3, R0, #-10
		BRnp NOT_SENTINEL
			STR R4, R2, #0
			BR END_LOOP
		NOT_SENTINEL
		STR R0, R2, #0
		ADD R2, R2, #1
		ADD R5, R5, #1
		BR LOOP
	END_LOOP

;Restore backed up registers
	LD R0, backup_r0
	LD R1, backup_r1
	LD R2, backup_r2
	LD R3, backup_r3
	LD R4, backup_r4
	;LD R5, backup_r5
	LD R6, backup_r6
	LD R7, backup_r7
;Return
	ret
;---------------	
;Local Data for subroutine
;---------------
	ENTER_CHARS .STRINGZ	"Enter a string of chars followed by ENTER\n"
	ZERO 		.FILL 		#0
	backup_r0	.BLKW #1
	backup_r1	.BLKW #1
	backup_r2	.BLKW #1
	backup_r3	.BLKW #1
	backup_r4	.BLKW #1
	;backup_r5	.BLKW #1
	backup_r6	.BLKW #1
	backup_r7	.BLKW #1
	
;-----------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME_3400
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1) is
;			a palindrome or not, and returned a flag to that effect.
; 			Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-----------------------------------------------------------------------
	.orig x3400
;========================
; Subroutine Instructions
;========================
;Backup affected Registers
	ST R0, backup_r0_3400
	ST R1, backup_r1_3400
	ST R2, backup_r2_3400
	ST R3, backup_r3_3400
	;ST R4, backup_r4_3400
	ST R5, backup_r5_3400
	ST R6, backup_r6_3400
	ST R7, backup_r7_3400
;-------------------------------
;Subroutine Algorithmn
;-------------------------------
	LD R6, SUB_TO_UPPER_3600
	JSRR R6
	ADD R2, R1, #0
	ADD R6, R5, #-1
	ADD R6, R6, R2
	AND R4, R4, #0
	ADD R4, R4, #1
	
	LOOP_1
		LDR R0, R2, #0
		LDR R3, R6, #0
		
		NOT R3, R3
		ADD R3, R3, #1
		ADD R3, R3, R0
		BRz SAME
			AND R4, R4, #0
			BR END_LOOP_1
		SAME
			ADD R2, R2, #1
			ADD R6, R6, #-1
			ADD R5, R5, #-1
			BRz END_LOOP_1
			BR LOOP_1
	END_LOOP_1
	

;Restore backed up registers
	LD R0, backup_r0_3400
	LD R1, backup_r1_3400
	LD R2, backup_r2_3400
	LD R3, backup_r3_3400
	;LD R4, backup_r4_3400
	LD R5, backup_r5_3400
	LD R6, backup_r6_3400
	LD R7, backup_r7_3400
;Return
	ret
;---------------	
;Local Data for subroutine
;---------------
	SUB_TO_UPPER_3600 .FILL x3600
	backup_r0_3400	.BLKW #1
	backup_r1_3400	.BLKW #1
	backup_r2_3400	.BLKW #1
	backup_r3_3400	.BLKW #1
	;backup_r4_3400	.BLKW #1
	backup_r5_3400	.BLKW #1
	backup_r6_3400	.BLKW #1
	backup_r7_3400	.BLKW #1

;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER_3600
; Parameter (R1): Starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case ​ in-place
;		i.e. the upper-case string has replaced the original string
; 		No return value, no output (but R1 still contains the array address, unchanged).
;------------------------------------------------------------------------------------------------------------------
	.org x3600
;========================
; Subroutine Instructions
;========================
;Backup affected Registers
	ST R0, backup_r0_3600
	ST R1, backup_r1_3600
	ST R2, backup_r2_3600
	ST R3, backup_r3_3600
	ST R4, backup_r4_3600
	ST R7, backup_r7_3600
;-------------------------------
;Subroutine Algorithmn
;-------------------------------
	ADD R2, R1, #0
	LD R4, BIT_MASK
	NOT R4, R4
	
	LOOP_2
		LDR R3, R2, #0
		BRz END_LOOP_2
		AND R3, R3, R4
		STR R3, R2, #0
		ADD R2, R2, #1
		BR LOOP_2
	END_LOOP_2
	
;Restore backed up registers
	LD R0, backup_r0_3600
	LD R1, backup_r1_3600
	LD R2, backup_r2_3600
	LD R3, backup_r3_3600
	LD R4, backup_r4_3600
	LD R7, backup_r7_3600
;Return
	ret
;---------------	
;Local Data for subroutine
;---------------
	BIT_MASK		.FILL x20
	backup_r0_3600	.BLKW #1
	backup_r1_3600	.BLKW #1
	backup_r2_3600	.BLKW #1
	backup_r3_3600	.BLKW #1
	backup_r4_3600	.BLKW #1
	backup_r7_3600	.BLKW #1

.end
