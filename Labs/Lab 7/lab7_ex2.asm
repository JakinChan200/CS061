;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================
	.orig x3000
	LEA R0, PROMPT
	PUTS
	GETC
	
	ADD R1, R0, #0
	LD R6, COUNT_ONES_3200
	JSRR R6
	
	LEA R0, ENDING_SEQUENCE
	PUTS
	ADD R0, R1, #0
	OUT
	LEA R0, MIDDLE_END
	PUTS
	
	LD R3, OFFSET
	ADD R0, R2, R3
	OUT

HALT
	COUNT_ONES_3200		.FILL x3200
	PROMPT				.STRINGZ  "Enter a single Character\n"
	ENDING_SEQUENCE		.STRINGZ  "The number of 1's in '"
	MIDDLE_END			.STRINGZ  "' is: "
	OFFSET				.FILL #48
;-----------------------------------------------------------------------
; Subroutine: COUNT_ONES_3200
; Parameter (R1): The character to count the 1s of
; Return(R2): The number of 1s
; Postcondition: The subroutine will load the number of 1s from
;				the character in R1 into R2
;-----------------------------------------------------------------------
	.orig x3200
;========================
; Subroutine Instructions
;========================
;Backup affected Registers
	ST R0, backup_r0_3200
	ST R1, backup_r1_3200
	ST R3, backup_r3_3200
	ST R4, backup_r4_3200
	ST R5, backup_r5_3200
	ST R6, backup_r6_3200
	ST R7, backup_r7_3200
;-------------------------------
;Subroutine Algorithmn
;-------------------------------
	LD R3, BIT_MASK
	LD R0, COUNTER
	NOT R5, R3				;Create Negative of Bit Mask
	ADD R5, R5, #1
	AND R2, R2, #0			;Reset R2 to 0
	LOOP
		AND R4, R1, R3		;Bit Mask the greatest Digit
		ADD R1, R1, R1		;Left-Shift
		ADD R4, R5, R4		;Check if greatest Digit is a 1
		BRnp NOT_ONE
			ADD R2, R2, #1	;Increment if is a 1
		NOT_ONE
		ADD R0, R0, #-1		;Decrement Counter
		BRp LOOP
	END_LOOP
	
;Restore backed up registers
	LD R0, backup_r0_3200
	LD R1, backup_r1_3200
	LD R3, backup_r3_3200
	LD R4, backup_r4_3200
	LD R5, backup_r5_3200
	LD R6, backup_r6_3200
	LD R7, backup_r7_3200
;Return
	ret
;---------------	
;Local Data for subroutine
;---------------
	BIT_MASK		.FILL x8000
	COUNTER			.FILL #16
	backup_r0_3200	.BLKW #1
	backup_r1_3200	.BLKW #1
	backup_r3_3200	.BLKW #1
	backup_r4_3200	.BLKW #1
	backup_r5_3200	.BLKW #1
	backup_r6_3200	.BLKW #1
	backup_r7_3200	.BLKW #1
.end
