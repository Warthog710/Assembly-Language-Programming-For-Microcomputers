; Assignment #7 - Program 1
; Quinn Roemer - W1582947

.586
.MODEL FLAT

INCLUDE io.h

.STACK 4096

.DATA						;This sections contain all of my variables.

number1		DWORD ?
two			DWORD 2


prompt1		BYTE "Enter a number:", 0	
oddLbl		BYTE "Number is odd.", 0
evenLbl		BYTE "Number is even.", 0
genericLbl	BYTE "Assignment #7", 0

string		BYTE 40 DUP (?)

.CODE						;This section contains all of my code.
_MainProc PROC

input prompt1, string, 40	;Asking the user to input a number.
atod string					;Converting and storing in EAX.
mov number1, eax			;Moving to the number1 variable.

call check					;Calling check procedure.

ret							;Returning

_MainProc ENDP				;End of main.

check PROC					;check code start.

mov edx, 0					;Moving 0 to EDX.
mov eax, number1			;Moving value in number1 to EAX.

idiv two					;Dividing EAX by 2.

cmp edx, 0					;Comparing value in EDX to 0.
je isEven					;If equal, jumping to isEven.
jmp isOdd					;Else, jumping to isOdd.

isEven:						;Outputting even message.				
	output genericLbl, evenLbl
	jmp exit				;Jumping to exit.

isOdd:						;Outputting odd message.
	output genericLbl, oddLbl
	jmp exit				;Jumping to exit.

exit:						;exit code start.
	ret						;Returning.

check ENDP					;check code end.

END							;End of Program.