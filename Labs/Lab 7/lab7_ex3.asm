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
	LD R1, VALUE
	LD R6, RIGHT_SHIFT_3200
	JSRR R6
HALT
	VALUE	.FILL x0002
	RIGHT_SHIFT_3200  .FILL x3200
;-----------------------------------------------------------------------
; Subroutine: RIGHT_SHIFT_3200
; Parameter (R1): Value to Right-Shift 
; Return(R1): The shifted Value
; Postcondition: The subroutine will right shift a value
;-----------------------------------------------------------------------
	.orig x3200
;========================
; Subroutine Instructions
;========================
;Backup affected Registers
	ST R0, backup_r0_3200
	ST R2, backup_r2_3200
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
			ADD R1, R1, #1	;Increment if is a 1
		NOT_ONE
		ADD R0, R0, #-1		;Decrement Counter
		BRp LOOP
	END_LOOP
	
;Restore backed up registers
	LD R0, backup_r0_3200
	LD R2, backup_r2_3200
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
	COUNTER			.FILL #15
	backup_r0_3200	.BLKW #1
	backup_r2_3200	.BLKW #1
	backup_r3_3200	.BLKW #1
	backup_r4_3200	.BLKW #1
	backup_r5_3200	.BLKW #1
	backup_r6_3200	.BLKW #1
	backup_r7_3200	.BLKW #1
.end
