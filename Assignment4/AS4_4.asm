; Assignment 3, this program asks for name, degree, and credits required/taken. It then outputs your name, degree, and credits needed.
; Quinn Roemer
; September 30th 2017

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096				; Reserving 4096 bytes of memory on the stack.

.DATA					; This is where all of my variables are declared.
number1				DWORD ? 
two					DWORD 2
prompt1				BYTE "Enter the number.", 0 
prompt2				BYTE "That number is negative.", 0 
prompt3				BYTE "That number is positive.", 0
prompt4				BYTE "That number is zero.", 0
temp				BYTE 40 DUP (?) 

.CODE ; This is where all of my code is written.
_MainProc PROC
       
	   input prompt1, temp, 40
	   atod temp

	   cmp eax, 0
	   jg positive
	   je zero

	   output prompt2, prompt2
	   jmp Quit

	   positive:
			output prompt3, prompt3
			jmp Quit

	   zero:
			output prompt4, prompt4
			jmp Quit


	   Quit: 	   
			mov eax, 0
			ret							;Returning.

_MainProc ENDP
END                             ;End of code.
