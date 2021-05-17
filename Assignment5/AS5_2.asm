; This program adds up all even numbers from 1-20.
; Quinn Roemer
; October 25th 2017

.586
.MODEL FLAT

INCLUDE io.h        ; header file for input/output

.STACK 4096			; Reserving 4096 bytes of memory on the stack.

.DATA				; This is where all of my variables are declared.

sum					DWORD 0
resultlbl			BYTE "The sum of even numbers 1-20 is...", 0 
temp				BYTE 40 DUP (?)

.CODE 				; This is where all of my code is written.

_MainProc PROC

mov ecx, 20			;Moving 20 into ECX

loopEven:			;Beginning of loop.
	mov eax, sum	;Moving sum into EAX.
	add eax, ecx	;Adding the value in ECX to EAX.
	mov sum, eax	;Moving the value in EAX to sum.
	dec ecx			;Decrementing ECX
	loop loopEven	;Looping back to loopEven

dtoa temp, sum			;Converting sum into string.
output resultlbl, temp	;Outputting the answer.
mov eax, 0				;Moving 0 into EAX
ret						;Returning

_MainProc ENDP
END                 ;End of code.