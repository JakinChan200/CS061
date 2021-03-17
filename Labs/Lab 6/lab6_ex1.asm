;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 6, ex 1
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
	
HALT
	SUB_GET_STRING_3200 .FILL x3200
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
	backup_r5	.BLKW #1
	backup_r6	.BLKW #1
	backup_r7	.BLKW #1
.end
