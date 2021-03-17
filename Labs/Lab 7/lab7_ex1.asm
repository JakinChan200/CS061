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
	LD R6, LOAD_VALUE_3200
	JSRR R6
	
	ADD R1, R1, #1
	
	LD R6, PRINT_DECIMAL_3400
	JSRR R6
	
HALT
	LOAD_VALUE_3200     .FILL x3200
	PRINT_DECIMAL_3400	.FILL x3400
;-----------------------------------------------------------------------
; Subroutine: LOAD_VALUE_3200
; Parameter : None
; Return(R1): A randome value hardcoded
; Postcondition: The subroutine will load the random hardcoded value into R1
;-----------------------------------------------------------------------
	.orig x3200
;========================
; Subroutine Instructions
;========================
;Backup affected Registers
	ST R7, backup_r7_3200
;-------------------------------
;Subroutine Algorithmn
;-------------------------------
	LD R1, RANDOM_NUMBER
;Restore backed up registers
	LD R7, backup_r7_3200
;Return
	ret
;---------------	
;Local Data for subroutine
;---------------
	RANDOM_NUMBER	.FILL #-1203
	backup_r7_3200	.BLKW #1
	
;-----------------------------------------------------------------------
; Subroutine: PRINT_DECIMAL_3400
; Parameter(R1): The number to convert to decimal
; Postcondition: The subroutine will print the random hardcoded value
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
	ST R4, backup_r4_3400
	ST R5, backup_r5_3400
	ST R6, backup_r6_3400
	ST R7, backup_r7_3400
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
	LD R0, backup_r0_3400
	LD R1, backup_r1_3400
	LD R2, backup_r2_3400
	LD R3, backup_r3_3400
	LD R4, backup_r4_3400
	LD R5, backup_r5_3400
	LD R6, backup_r6_3400
	LD R7, backup_r7_3400
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
	backup_r0_3400	.BLKW #1
	backup_r1_3400	.BLKW #1
	backup_r2_3400	.BLKW #1
	backup_r3_3400	.BLKW #1
	backup_r4_3400	.BLKW #1
	backup_r5_3400	.BLKW #1
	backup_r6_3400	.BLKW #1
	backup_r7_3400	.BLKW #1
.end
