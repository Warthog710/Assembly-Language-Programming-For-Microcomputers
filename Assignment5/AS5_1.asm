; This program determines if a user-entered number is positive or negative.
; It loops until zero is entered.
; Quinn Roemer
; October 25th 2017

.586
.MODEL FLAT

INCLUDE io.h        ; header file for input/output

.STACK 4096			; Reserving 4096 bytes of memory on the stack.

.DATA				; This is where all of my variables are declared.

number				DWORD ?
prompt1				BYTE "Enter a number.", 0 
resultlbl1			BYTE "That number is positive.", 0 
resultlbl2			BYTE "That number is negative.", 0
resultlbl3			BYTE "Goodbye!", 0
temp				BYTE 40 DUP (?) 

.CODE 				; This is where all of my code is written.

_MainProc PROC

loopPN:								;Beginning of the loop. It will iterate to the value of ecx.
		input prompt1, temp, 40		;Asking the user to input a number.
		atod temp					;Converting string to decimal
		cmp eax, 0					;Comparing to stored greater number.
		jg isGreat					;Jumping if the number is greater or equal.
		jl isSmall					;Jumping if the number is smaller.
		je isZero					;Jumping if the number is zero.
		
		isGreat:					;If the new number is greater this code will be executed.
			output resultlbl1, resultlbl1		;Moving the new number into greater.
			jmp loopPN				;Jumping to continue.

		isSmall:	
			output resultlbl2, resultlbl2		;If the new number is smaller this code will be executed.
			jmp loopPN				;Jumping to continue

		isZero:						;When jumped to continue this code will execute.
			mov eax, 0				;Looping to loopFive
			output resultlbl3, resultlbl3		;Saying Goodbye!
			ret						;Returning

_MainProc ENDP
END                             	;End of code.