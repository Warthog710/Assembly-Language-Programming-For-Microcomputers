.586
.MODEL FLAT

INCLUDE io.h

.STACK 4096

.DATA					;This is where all my variables are declared.

string BYTE 40 DUP (?)
prompt1 BYTE "Enter a number", 0
genericLbl BYTE "Insertion Sort", 0

array DWORD 10 DUP (?)
temp  DWORD ?
sizeArray DWORD 9
addMod	DWORD 0
counter	DWORD 9


.CODE					;This is where my code starts.
_MainProc PROC

lea esi, array			;Loading address of array into ESI.
mov ecx, 10				;Moving 10 to ECX.

loadArray:				;Prompting user of input.
	input prompt1, string, 40
	atod string			;Converting string and storing in EAX.

	mov [esi], eax		;Moving the value in eax to the address of ESI.

	add esi, 4			;Adding 4 to ESI.

loop loadArray			;Looping to the value of ECX.

mov edx, 0				;Moving 0 to EDX.

sortArray:				;sortArray code start.

lea esi, array			;Loading the address of array into ESI.
add esi, addMod			;Adding the value of addMod to ESI.
mov eax, 0				;Moving 0 to EAX.
add eax, [esi]			;Adding value pointed to by ESI to EAX.
mov edi, esi			;Moving the value in ESI to EDI.
mov temp, eax			;Setting temp to EAX.
mov ecx, counter		;Moving the value in counter to ECX.

	insertionSort:		;InsertionSort code start.
		add esi, 4		;Adding 4 to ESI.
		mov eax, temp	;Moving the value in Temp to EAX.
		mov ebx, 0		;Moving 0 to EBX.
		add ebx, [esi]	;Adding value pointed to by ESI to EAX.
		cmp eax, ebx	;Comparing value in EAX to EBX.
		jg isSmall		;If greater, jumping to isSmall.
		jmp continue	;Else, jumping to continue.

		isSmall:			;isSmall code start.
			mov temp, ebx	;Moving the value in EBX to temp.
			mov edi, esi	;Moving value in ESI to EDI.
			jmp continue	;Jumping to continue.

		continue:			;continue code start.
		loop insertionSort	;Looping to the value of ECX.

	inc edx				;Incrementing the value in EDX.
	lea esi, array		;Loading address of array into ESI.
	add esi, addMod		;Adding addMod to value in ESI.
	mov eax, 0			;Setting EAX to 0.
	add eax, [esi]		;Adding value pointed to by ESI to EAX.
	mov ebx, 0			;Setting EBX to 0.
	add ebx, [edi]		;Adding value pointed to by EDI to EBX.
	mov [esi], ebx		;Moving value in EBX to address of ESI.
	mov [edi], eax		;Moving value in EAX to address of EDI.
	dec counter			;Decrementing the counter.
	add addMod, 4		;Adding 4 to addMod.
	cmp sizeArray, edx	;Comparing the variable sizeArray to EDX.
	jg sortArray		;If greater jumping to sortArray.
	jmp print			;Else, jumping to print.

print:					;Print code start.
	mov ecx, 10			;Moving 10 to ECX.
	lea esi, array		;Loading address of array into ESI.
	printLoop:			;printLoop code start.
		dtoa string, [esi]			;Converting variable.
		output genericLbl, string	;Outputting variable.
		add esi, 4					;Adding 4 to ESI.
		loop printLoop				;Looping to value of ECX.

_MainProc ENDP			;MainProc End.
END						;End of Program.