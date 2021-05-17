; This program asks the user to enter 5 numbers into an array.
; it then prompts the user to enter a number to be searched for.
; the program then searches the array for the number.

; Quinn Roemer
;Novemeber 16th 2017

.586
.MODEL FLAT

INCLUDE io.h

.STACK 4096

;This is where all of my variables are declared.

.DATA

;These variables hold my message box labels and prompts.

prompt2		BYTE "Enter a number to search for.", 0
notFoundLbl	BYTE "Failed to find that number.", 0
foundLbl	BYTE "That number was found.", 0
prompt1		BYTE "Enter a number.", 0
genericLbl	BYTE "Assignment #6", 0

;These variables are my character arrays and number arrays.

temp		BYTE 40 DUP (?)
numArray	DWORD 5 DUP (?)

;This is where my code starts.

.CODE
_MainProc PROC					;MainProc code start.

mov		ecx, 5					;Setting ECX to 5.

lea		ebx, numArray			;Loading address of numArray.

numEnter:						;numEnter loop start.
	
	input	prompt1, temp, 40	;Prompting user for input.
	atod	temp				;Converting and storing in EAX.
	mov		[ebx], eax			;Moving input into array.
	add		ebx, 4				;Increment EBX by 4.

loop	numEnter				;numEnter loop end.

input	prompt2, temp, 40		;Prompting user for input.
atod	temp					;Converting and storing in EAX.

mov		ecx, 5					;Setting ECX to 5.
lea		ebx, numArray			;Loading address of numArray.

searchLoop:						;searchLoop loop start.
	
	cmp		eax, [ebx]			;Comparing number in array to EAX.
	je		Equal				;Jumping if equal to Equal

	add		ebx, 4				;Increment EBX by 4.

loop	searchLoop				;searchLoop loop end.

output	genericLbl, notFoundLbl	;Telling user number was not found.
jmp		Quit					;Jumping to Quit.

Equal:							;Equal code start.
	output	genericLbl, foundLbl ;Telling user number was found.
	jmp		Quit				;Jumping to Quit.

Quit:							;Quit code start.
	mov		eax, 0				;Setting EAX to 0.
	ret							;Returning.

_MainProc ENDP                  ;MainProc End.
END								;End Program.