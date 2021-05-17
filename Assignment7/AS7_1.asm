; Assignment #7 - Program 1
; Quinn Roemer - W1582947

.586
.MODEL FLAT

INCLUDE io.h

.STACK 4096

.DATA						;This sections contain all of my variables.

sum			DWORD ?
number1		DWORD ?
number2		DWORD ?
number3		DWORD ?

prompt1		BYTE "Enter a number:", 0	
endLbl		BYTE "Sum of numbers:", 0

string		BYTE 40 DUP (?)

.CODE						;This section contains all of my code.
_MainProc PROC

input prompt1, string, 40	;Asking the user to input the first number.
atod string					;Converting and storing in EAX.
mov number1, eax			;Moving to the number1 variable.

input prompt1, string, 40	;Asking the user to input the second number.	
atod string					;Converting and storing in EAX.
mov number2, eax			;Moving to the number1 variable.

input prompt1, string, 40	;Asking the user to input the third number.
atod string					;Converting and storing in EAX.
mov number3, eax			;Moving to the number1 variable.

call add3					;Calling add3 procedure.

dtoa string, sum			;Converting value in sum to ASCII
output endLbl, string		;Outputting sum.

ret							;Returning

_MainProc ENDP				;End of main.

add3 PROC					;add3 code start.

mov eax, number1			;Moving number1 to EAX.

add eax, number2			;Adding number2 to EAX.
add eax, number3			;Adding number3 to EAX.

mov sum, eax				;Moving value in EAX to sum.

ret							;Returning.

add3 ENDP					;add end.

END							;End of Program.