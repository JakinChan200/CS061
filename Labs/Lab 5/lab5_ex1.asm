;=================================================
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Lab: lab 5, ex 1
; Lab section: 22
; TA: Jason Zellmer
; 
;=================================================

.orig x3000
	
	LD R1, POINTER			
	LD R2, COUNTER
	LD R3, ONE
	
	LOOP
		STR R3, R1, #0			;Store value into address in R1
		ADD R3, R3, R3			;Double Value
		ADD R1, R1, #1			;Increment address
		ADD R2, R2, #-1			;Decrement counter
		BRp LOOP
	END_LOOP
	
	LD R1, POINTER				;Reset R1 to point to head of array
	LDR R2, R1, #6				;Get 6th value from head and put in R2
	LD R2, COUNTER				;Reset Counter
	
	LOOP_2
		LDR R0, R1, #0			;Load value into R0
		LD R6, PRINT_SUBROUTINE_3200
		JSRR R6
		ADD R1, R1, #1			;Increment address
		ADD R2, R2, #-1			;Decrement counter
		BRp LOOP_2
	END_LOOP_2

HALT
	POINTER .FILL x4000
	COUNTER .FILL #10
	ONE		.FILL x1
	PRINT_SUBROUTINE_3200 .FILL x3200
	.orig x4000
	.BLKW #10
	
;=======================================================================
; Subroutine: PRINT_SUBROUTINE_3200
; Parameter: R6, contains address of binary pattern to print
; Postcondition: Prints what is contained in the address in binary
; Return Value: No return value
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
	ST R5, backup_r5
	ST R6, backup_r6
	ST R7, backup_r7
;-------------------------------
;Subroutine Algorithmn
;-------------------------------
ADD R6, R1, #0	
;LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 

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
	LD R2, backup_r2
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
;Value_ptr	.FILL xCB00	; The address where value to be displayed is stored
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

;.ORIG xCB00					; Remote data
;Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
	
.end
