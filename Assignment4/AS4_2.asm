; Assignment 3, this program asks for name, degree, and credits required/taken. It then outputs your name, degree, and credits needed.
; Quinn Roemer
; September 30th 2017

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096				; Reserving 4096 bytes of memory on the stack.

.DATA					; This is where all of my variables are declared.
number1				DWORD ? 
number2				DWORD ?	
number3				DWORD ?
prompt1				BYTE "Enter the first number.", 0 
prompt2				BYTE "Enter the second number", 0 
prompt3				BYTE "Enter the third number.", 0
prompt4  			BYTE "The first number is greater.", 0 
prompt5 			BYTE "The second number is greater.", 0 
prompt6 			BYTE "The third number is greater.", 0

temp				BYTE 40 DUP (?) 

.CODE ; This is where all of my code is written.
_MainProc PROC
       
	   input prompt1, temp, 40
	   atod temp
	   mov number1, eax

	   input prompt2, temp, 40
	   atod temp
	   mov number2, eax

	   input prompt3, temp, 40
	   atod temp

	   cmp number2, eax
	   jg greater
	   	
	   cmp number1, eax
	   jg num1Greater

	   output prompt6, prompt6
	   jmp Quit

	   greater: 
			mov eax, number1
			cmp number2, eax
			jg evenGreater
			output prompt4, prompt4
			jmp Quit

		evenGreater:
			output prompt5, prompt5
			jmp Quit

		num1Greater:
			output prompt4, prompt4
			jmp Quit

	   Quit: 	   
			mov eax, 0
			ret							;Returning.

_MainProc ENDP
END                             ;End of code.
