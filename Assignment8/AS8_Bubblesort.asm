.586
.MODEL FLAT

INCLUDE io.h

.STACK 4096

.DATA						;This is where my variables are declared.

string BYTE 40 DUP (?)
prompt1 BYTE "Enter a number", 0
genericLbl BYTE "Bubble Sort", 0

array DWORD 10 DUP (?)
temp  DWORD ?
sizeArray DWORD 10


.CODE						;This is where my code starts.
_MainProc PROC

lea esi, array				;Loading the address of array into ESI.
mov ecx, 10					;Moving 10 into ECX.

loadArray:					;Prompting user to input number.
	input prompt1, string, 40
	atod string				;Converting string and storing in EAX.

	mov [esi], eax			;Moving value in EAX to address ESI.

	add esi, 4				;Adding 4 to ESI.

loop loadArray				;Looping to the value of ECX.

mov edx, 0					;Moving 0 to EDX.

sortArray:					;SortArray code start.

lea esi, array				;Loading address of array to ESI.
lea edi, array				;Loading address of array in EDI.
mov ecx, 9					;Moving 9 into ECX.

	bubbleSort:				;BubbleSort code start.
		add edi, 4			;Adding 4 to EDI.
		mov eax, 0			;Moving 0 to EAX.
		mov ebx, 0			;Moving 0 to EBX.
		add eax, [esi]		;Adding value pointed to by ESI to EAX.
		add ebx, [edi]		;Adding value pointed to by EDI to EBX.
		cmp eax, ebx		;Comparing EAX to EBX.
		jge move			;If greater or equal, jumping to move.
		jmp continue		;Else, jumping to continue.

		move:				;Move code start.
			mov [edi], eax	;Moving value in EAX to address in EDI.
			mov [esi], ebx	;Moving value in EBX to address of EBX.
			jmp continue	;Jumping to continue.

		continue:			;Continue code start.	
			add esi, 4		;Adding 4 to ESI.
			loop bubbleSort	;Looping to the value of ECX.

	inc edx					;Incrementing EDX.
	cmp sizeArray, edx		;Comparing value in sizeArray to EDX.
	jge sortArray			;If greater or equal, jumping to sortArray.
	jmp print				;Else, jumping to print.

print:						;Print code start.
	mov ecx, 10				;Moving 10 into ECX.
	lea esi, array			;Loading address of array into ESI.
	printLoop:				;Printloop code start.
		dtoa string, [esi]			;Converting variable.
		output genericLbl, string	;Outputting variable.
		add esi, 4					;Adding 4 to ESI.
		loop printLoop				;Looping printLoop.

_MainProc ENDP				;MainProc End.
END							;End of Program.