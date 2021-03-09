;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Jakin Chan
; Email: jchan419@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================
; Busyness vector: xB600 

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
	MAIN_LOOP
		LD R6, MENU_SUBROUTINE
		JSRR R6
		ADD R1, R1, #-1
		BRp IS_NOT_ONE						;ALL_MACHINES_BUSY
			LD R6, ALL_MACHINES_BUSY
			JSRR R6
			ADD R2, R2, #0
			BRz NOT_ALL_BUSY
				LEA R0, allbusy
				PUTS
				BR MAIN_LOOP
			NOT_ALL_BUSY
			LEA R0, allnotbusy
			PUTS
			BR MAIN_LOOP
		IS_NOT_ONE
		ADD R1, R1, #-1
		BRp IS_NOT_TWO						;ALL_MACHINES_FREE
			LD R6, ALL_MACHINES_FREE
			JSRR R6
			ADD R2, R2, #0
			BRz NOT_ALL_FREE
				LEA R0, allfree
				PUTS
				BR MAIN_LOOP
			NOT_ALL_FREE
			LEA R0, allnotfree
			PUTS
			BR MAIN_LOOP
		IS_NOT_TWO
		ADD R1, R1, #-1
		BRp IS_NOT_THREE					;NUM_BUSY_MACHINES
			LD R6, NUM_BUSY_MACHINES
			JSRR R6
			LEA R0, busymachine1
			PUTS
			LD R6, PRINT_NUM
			JSRR R6
			LEA R0, busymachine2
			PUTS
			BR MAIN_LOOP
		IS_NOT_THREE
		ADD R1, R1, #-1		
		BRp IS_NOT_FOUR						;NUM_FREE_MACHINES
			LD R6, NUM_FREE_MACHINES
			JSRR R6
			LEA R0, freemachine1
			PUTS
			LD R6, PRINT_NUM
			JSRR R6
			LEA R0, freemachine2
			PUTS
			BR MAIN_LOOP
		IS_NOT_FOUR							;MACHINE_STATUS
		ADD R1, R1, #-1		
		BRp IS_NOT_FIVE
			LD R6, MACHINE_STATUS
			JSRR R6
			LEA R0, status1
			PUTS
			LD R6, PRINT_NUM
			JSRR R6
			ADD R2, R2, #0
			BRz MACHINE_IS_BUSY
				LEA R0, status3
				PUTS
				BR MAIN_LOOP
			MACHINE_IS_BUSY
			LEA R0, status2
			PUTS
			BR MAIN_LOOP
		IS_NOT_FIVE							;FIRST_FREE
		ADD R1, R1, #-1		
		BRp IS_NOT_SIX
			LD R6, FIRST_FREE
			JSRR R6
			ADD R1, R1, #0
			BRzp A_MACHINE_FREE
				LEA R0, firstfree2
				PUTS
				BR MAIN_LOOP
			A_MACHINE_FREE
			LEA R0, firstfree1
			PUTS
			LD R6, PRINT_NUM
			JSRR R6
			LD R0, newline
			OUT
			BR MAIN_LOOP
		IS_NOT_SIX
	END_MAIN_LOOP
	LEA R0, goodbye
	PUTS
HALT
;---------------	
;Data
;---------------
;Subroutine pointers



;Other data 
newline 			.fill '\n'
MENU_SUBROUTINE 	.FILL x3200
ALL_MACHINES_BUSY 	.FILL x3400
ALL_MACHINES_FREE	.FILL x3600
NUM_BUSY_MACHINES	.FILL x3800
NUM_FREE_MACHINES	.FILL x4000
MACHINE_STATUS		.FILL x4200
FIRST_FREE			.FILL x4400
PRINT_NUM			.FILL x4800
; Strings for reports from menu subroutines:
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
	.orig x3200
;HINT back up 
	ST R0, backup_r0_3200
	ST R2, backup_r2_3200
	ST R7, backup_r7_3200
	
	MENU_LOOP
		AND R2, R2, #0
		LD R0, Menu_string_addr
		PUTS
		GETC
		OUT
		
		ADD R1, R0, #0
		LD R0, NEWLINE_3200
		OUT
		ADD R1, R1, #-15
		ADD R1, R1, #-15
		ADD R1, R1, #-15
		ADD R1, R1, #-3
		BRp SKIP_ERROR_MESSAGE
			LEA R0, Error_msg_1
			PUTS
			BR MENU_LOOP
		SKIP_ERROR_MESSAGE
		ADD R2, R2, #1
		ADD R1, R1, #-1
		BRp NOT_ONE
			BR END_MENU_LOOP
		NOT_ONE
		ADD R2, R2, #1
		ADD R1, R1, #-1
		BRp NOT_TWO
			BR END_MENU_LOOP
		NOT_TWO
		ADD R2, R2, #1
		ADD R1, R1, #-1
		BRp NOT_THREE
			BR END_MENU_LOOP
		NOT_THREE
		ADD R2, R2, #1
		ADD R1, R1, #-1
		BRp NOT_FOUR
			BR END_MENU_LOOP
		NOT_FOUR
		ADD R2, R2, #1
		ADD R1, R1, #-1
		BRp NOT_FIVE
			BR END_MENU_LOOP
		NOT_FIVE
		ADD R2, R2, #1
		ADD R1, R1, #-1
		BRp NOT_SIX
			BR END_MENU_LOOP
		NOT_SIX
		ADD R2, R2, #1
		ADD R1, R1, #-1
		BRp NOT_SEVEN
			BR END_MENU_LOOP
		NOT_SEVEN
		LEA R0, Error_msg_1
		PUTS
		BR MENU_LOOP
	END_MENU_LOOP
	
	ADD R1, R2, #0
;HINT Restore
	LD R0, backup_r0_3200
	LD R2, backup_r2_3200
	LD R7, backup_r7_3200

ret
;--------------------------------
;Data for subroutine MENU
;--------------------------------
	Error_msg_1	      .STRINGZ "INVALID INPUT\n"
	Menu_string_addr  .FILL x5000
	NEWLINE_3200	  .FILL '\n'
	backup_r0_3200 	.BLKW #1
	backup_r2_3200 	.BLKW #1
	backup_r7_3200 	.BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
	.orig x3400
;HINT back up 
	ST R0, backup_r0_3400
	ST R1, backup_r1_3400
	ST R3, backup_r3_3400
	ST R5, backup_r5_3400
	ST R7, backup_r7_3400
	;0, busy, 1, free
	
	AND R2, R2, #0
	LD R1, COUNTER_3400
	LD R3, BIT_MASK_3400
	LDI R0, BUSYNESS_ADDR_ALL_MACHINES_BUSY
	BUSY_LOOP
		AND R5, R3, R0
		BRz IS_BUSY
			ADD R2, R2, #1					;Add 1 if machine is FREE
			BR END_BUSY_LOOP				;Break
		IS_BUSY
		ADD R0, R0, R0
		ADD R1, R1, #-1
		BRp BUSY_LOOP
	END_BUSY_LOOP
	
	ADD R2, R2, #0
	BRz ALL_BUSY
		AND R2, R2, #0
		BR END_BUSY
	ALL_BUSY
		ADD R2, R2, #1
	END_BUSY
	
;HINT Restore
	LD R0, backup_r0_3400
	LD R1, backup_r1_3400
	LD R3, backup_r3_3400
	LD R5, backup_r5_3400
	LD R7, backup_r7_3400
ret
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xB600
	backup_r0_3400 	.BLKW #1
	backup_r1_3400 	.BLKW #1
	backup_r3_3400 	.BLKW #1
	backup_r5_3400 	.BLKW #1
	backup_r7_3400 	.BLKW #1
	BIT_MASK_3400	.FILL x8000
	COUNTER_3400	.FILL #16
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
	.orig x3600
;HINT back up 
	ST R0, backup_r0_3600
	ST R1, backup_r1_3600
	ST R3, backup_r3_3600
	ST R5, backup_r5_3600
	ST R7, backup_r7_3600
	;0 busy, 1, free return 1 if free, 0 otherwise
	
	AND R2, R2, #0
	LD R1, COUNTER_3600
	LD R3, BIT_MASK_3600
	LDI R0, BUSYNESS_ADDR_ALL_MACHINES_FREE
	FREE_LOOP
		AND R5, R3, R0
		BRnp IS_FREE
			ADD R2, R2, #1					;Add 1 if machine is BUSY
			BR END_FREE_LOOP				;Break
		IS_FREE
		ADD R0, R0, R0
		ADD R1, R1, #-1
		BRp FREE_LOOP
	END_FREE_LOOP
	
	ADD R2, R2, #0
	BRz ALL_FREE
		AND R2, R2, #0
		BR END_FREE
	ALL_FREE
		ADD R2, R2, #1
	END_FREE
;HINT Restore
	LD R0, backup_r0_3600
	LD R1, backup_r1_3600
	LD R3, backup_r3_3600
	LD R5, backup_r5_3600
	LD R7, backup_r7_3600
ret
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xB600
	backup_r0_3600 	.BLKW #1
	backup_r1_3600 	.BLKW #1
	backup_r3_3600 	.BLKW #1
	backup_r5_3600 	.BLKW #1
	backup_r7_3600 	.BLKW #1
	BIT_MASK_3600	.FILL x8000
	COUNTER_3600	.FILL #16
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
	.orig x3800
;HINT back up 
	ST R0, backup_r0_3800
	ST R2, backup_r2_3800
	ST R3, backup_r3_3800
	ST R5, backup_r5_3800
	ST R7, backup_r7_3800
	
	AND R1, R1, #0
	LD R2, COUNTER_3800
	LD R3, BIT_MASK_3800
	LDI R0, BUSYNESS_ADDR_NUM_BUSY_MACHINES
	COUNT_BUSY_LOOP
		AND R5, R3, R0
		BRnp NOT_BUSY_1
			ADD R1, R1, #1
		NOT_BUSY_1
		ADD R0, R0, R0
		ADD R2, R2, #-1
		BRp COUNT_BUSY_LOOP
;HINT Restore
	LD R0, backup_r0_3800
	LD R2, backup_r2_3800
	LD R3, backup_r3_3800
	LD R5, backup_r5_3800
	LD R7, backup_r7_3800
ret
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xB600
	backup_r0_3800 	.BLKW #1
	backup_r2_3800 	.BLKW #1
	backup_r3_3800 	.BLKW #1
	backup_r5_3800 	.BLKW #1
	backup_r7_3800 	.BLKW #1
	BIT_MASK_3800	.FILL x8000
	COUNTER_3800	.FILL #16
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
	.orig x4000
;HINT back up 
	ST R0, backup_r0_4000
	ST R2, backup_r2_4000
	ST R3, backup_r3_4000
	ST R5, backup_r5_4000
	ST R7, backup_r7_4000
	
	AND R1, R1, #0
	LD R2, COUNTER_4000
	LD R3, BIT_MASK_4000
	LDI R0, BUSYNESS_ADDR_NUM_FREE_MACHINES
	COUNT_FREE_LOOP
		AND R5, R3, R0
		BRz NOT_FREE_1
			ADD R1, R1, #1
		NOT_FREE_1
		ADD R0, R0, R0
		ADD R2, R2, #-1
		BRp COUNT_FREE_LOOP

;HINT Restore
	LD R0, backup_r0_4000
	LD R2, backup_r2_4000
	LD R3, backup_r3_4000
	LD R5, backup_r5_4000
	LD R7, backup_r7_4000
ret
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xB600
	backup_r0_4000 	.BLKW #1
	backup_r2_4000 	.BLKW #1
	backup_r3_4000 	.BLKW #1
	backup_r5_4000 	.BLKW #1
	backup_r7_4000 	.BLKW #1
	BIT_MASK_4000	.FILL x8000
	COUNTER_4000	.FILL #16

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
	.orig x4200
;HINT back up 
	ST R0, backup_r0_4200
	ST R3, backup_r3_4200
	ST R4, backup_r4_4200
	ST R7, backup_r7_4200
	
	LD R6, GET_MACHINE_NUM
	JSRR R6
	
	LDI R0, BUSYNESS_ADDR_MACHINE_STATUS
	LD R4, BIT_MASK_4200
	LD R3, NUM_BITS
	
	ADD R3, R3, R1
	BRz END_FIND_MACHINE
	FIND_MACHINE					;left-shift till machine is lmb
		ADD R0, R0, R0
		ADD R3, R3, #1
		BRn FIND_MACHINE
	END_FIND_MACHINE
	
	AND R2, R2, #0					;Set R2 to 0 or 1
	AND R4, R4, R0
	BRz MACHINE_BUSY
		ADD R2, R2, #1
	MACHINE_BUSY
	
;HINT Restore
	LD R0, backup_r0_4200
	LD R3, backup_r3_4200
	LD R4, backup_r4_4200
	LD R7, backup_r7_4200
ret
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xB600
GET_MACHINE_NUM			.FILL x4600
	NUM_BITS		.FILL #-15
	BIT_MASK_4200	.FILL x8000
	backup_r0_4200 	.BLKW #1
	backup_r3_4200 	.BLKW #1
	backup_r4_4200 	.BLKW #1
	backup_r7_4200 	.BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R1): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
	.orig x4400
;HINT back up 
	ST R0, backup_r0_4400
	ST R2, backup_r2_4400
	ST R3, backup_r3_4400
	ST R4, backup_r4_4400
	ST R5, backup_r5_4400
	ST R6, backup_r6_4400
	ST R7, backup_r7_4400
	
	LDI R0, BUSYNESS_ADDR_FIRST_FREE
	LD R3, BIT_MASK_4400
	LD R4, COUNTER_4400
	LD R6, BIT_MASK_4400_1
	AND R1, R1, #0
	MAIN_FIRST_FREE_LOOP
		AND R5, R3, R0
		BRz NOT_LOWEST_FREE
			BR END_OF_SUBROUTINE
		NOT_LOWEST_FREE
		LD R2, SHIFT_COUNTER
		RIGHT_SHIFT
			AND R5, R0, R6		;Bit Mask the greatest Digit
			ADD R0, R0, R0		;Left-Shift
			ADD R5, R5, #0		;Check if greatest Digit is a 1
			BRz MSB_NOT_ONE
				ADD R0, R0, #1	;Increment if is a 1
			MSB_NOT_ONE
			ADD R2, R2, #-1
			BRp RIGHT_SHIFT
		END_RIGHT_SHIFT
		ADD R1, R1, #1
		ADD R4, R4, #-1
		BRp MAIN_FIRST_FREE_LOOP
	END_MAIN_FIRST_FREE_LOOP
	AND R1, R1, #0
	ADD R1, R1, #-1
	END_OF_SUBROUTINE
;HINT Restore
	LD R0, backup_r0_4400
	LD R2, backup_r2_4400
	LD R3, backup_r3_4400
	LD R4, backup_r4_4400
	LD R5, backup_r5_4400
	LD R6, backup_r6_4400
	LD R7, backup_r7_4400
ret
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xB600
	backup_r0_4400 	.BLKW #1
	backup_r2_4400 	.BLKW #1
	backup_r3_4400 	.BLKW #1
	backup_r4_4400 	.BLKW #1
	backup_r5_4400 	.BLKW #1
	backup_r6_4400 	.BLKW #1
	backup_r7_4400 	.BLKW #1
	SHIFT_COUNTER	.FILL #15
	COUNTER_4400	.FILL #16
	BIT_MASK_4400	.FILL x1
	BIT_MASK_4400_1	.FILL x8000
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
	.orig x4600
;HINT back up 
	ST R0, backup_r0_4600
	ST R2, backup_r2_4600
	ST R3, backup_r3_4600
	ST R4, backup_r4_4600
	ST R5, backup_r5_4600
	ST R6, backup_r6_4600
	ST R7, backup_r7_4600
	
	GET_MACHINE_NUM_MAIN_LOOP
		LEA R0, prompt
		PUTS
		
		;LD R5, COUNTER_2
		AND R6, R6, #0
		AND R1, R1, #0
		LOOP_2
			GETC
			OUT
			ADD R2, R0, #-10
			BRz TEST_OVERFLOW
			ADD R2, R2, #-15
			ADD R2, R2, #-15
			ADD R2, R2, #-8
			BRzp NOT_TOO_SMALL
				LD R0, NEWLINE_4400
				OUT
				LEA R0, Error_msg_2
				PUTS
				BR GET_MACHINE_NUM_MAIN_LOOP
			NOT_TOO_SMALL
			ADD R2, R2, #-9
			BRnz VALID_NUMBER
				LD R0, NEWLINE_4400
				OUT
				LEA R0, Error_msg_2
				PUTS
				BR GET_MACHINE_NUM_MAIN_LOOP
			VALID_NUMBER
			
			ADD R6, R6, #1
			ADD R2, R2, #9
			ADD R3, R1, #0
			LD R4, COUNTER_10
			MULTIPLY_BY_TEN
				ADD R1, R3, R1
				ADD R4, R4, #-1
				BRp MULTIPLY_BY_TEN
			END_MULTIPLY_BY_TEN
			ADD R1, R2, R1
			;ADD R5, R5, #-1
			BR LOOP_2
		END_LOOP_2
	END_GET_MACHINE_NUM_MAIN_LOOP
		LD R0, NEWLINE_4400
		OUT
		
	TEST_OVERFLOW
	ADD R4, R1, #-15
	BRnz NOTHING_WRONG
		LD R0, NEWLINE_4400
		OUT
		LEA R0, Error_msg_2
		PUTS
		BR GET_MACHINE_NUM_MAIN_LOOP
	NOTHING_WRONG
	
	ADD R6, R6, #0						;Check if first char is ENTER
	BRp SKIP_THIS_PART
		LD R0, NEWLINE_4400
		OUT
		LEA R0, Error_msg_2
		PUTS
		BR GET_MACHINE_NUM_MAIN_LOOP
	SKIP_THIS_PART
;HINT Restore
	LD R0, backup_r0_4600
	LD R2, backup_r2_4600
	LD R3, backup_r3_4600
	LD R4, backup_r4_4600
	LD R5, backup_r5_4600
	LD R6, backup_r6_4600
	LD R7, backup_r7_4600
ret
;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
	NEWLINE_4400	.FILL '\n'
	COUNTER_10		.FILL #9
	COUNTER_2		.FILL #2
	backup_r0_4600 	.BLKW #1
	backup_r2_4600 	.BLKW #1
	backup_r3_4600 	.BLKW #1
	backup_r4_4600 	.BLKW #1
	backup_r5_4600 	.BLKW #1
	backup_r6_4600 	.BLKW #1
	backup_r7_4600 	.BLKW #1
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,16}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
		.orig x4800
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
	ST R0, backup_r0_4800
	ST R7, backup_r7_4800
	
	ADD R1, R1, #-10
	BRn NOT_TEN_PLUS
		LD R0, ONE
		OUT
		LD R0, OFFSET
		ADD R0, R1, R0
		OUT
		BR END_PRINT
	NOT_TEN_PLUS
		ADD R1, R1, #10
		LD R0, OFFSET
		ADD R0, R1, R0
		OUT
	END_PRINT
	
	LD R0, backup_r0_4800
	LD R7, backup_r7_4800
ret
;--------------------------------
;Data for subroutine print number
;--------------------------------
OFFSET		.FILL #48
ONE			.FILL #49
ZERO		.FILL #48
backup_r0_4800 	.BLKW #1
backup_r7_4800 	.BLKW #1


.ORIG x5000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xB600			; Remote data
BUSYNESS .FILL x8000		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program. 1010 1011 1100 1101

;---------------	
;END of PROGRAM
;---------------	
.END
