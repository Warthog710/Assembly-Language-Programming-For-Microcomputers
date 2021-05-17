; Assignment 4, this program asks for two numbers. It then tells the user which number is greater.
; Quinn Roemer
; October 19th 2017

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096				; Reserving 4096 bytes of memory on the stack.

.DATA					; This is where all of my variables are declared.
number1				DWORD ? 
number2				DWORD ?	
prompt1				BYTE "Enter the first number.", 0 
prompt2				BYTE "Enter the second number", 0 
prompt3				BYTE "The first number is greater.", 0 
prompt4				BYTE "The second number is greater.", 0 
temp				BYTE 40 DUP (?) 

.CODE ; This is where all of my code is written.
_MainProc PROC
       
	   input prompt1, temp, 40
	   atod temp
	   mov number1, eax

	   input prompt2, temp, 40
	   atod temp

	   cmp number1, eax
	   jg greater

	
	   output prompt4, prompt4
	   jmp Quit

	   greater: 
			output prompt3, prompt3
			jmp Quit

	   Quit: 	   
			mov eax, 0
			ret							;Returning.

_MainProc ENDP
END                             ;End of code.
