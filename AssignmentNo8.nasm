;							ASSIGNMENT 8
;ASSIGNMENT STATEMENT:- Write 64 bit program to sort the list of integers using bubble sort and file.

;NAME: VIKAS DONGARE
;CLASSS: SE-B
;ROLL NO: 15


global _start
 _start :
%include "macro.nasm"

section .text

	    pop rcx  ; no of arguments
		pop rcx  ;	programme name
		pop rcx  ;	filename
		mov [filename],rcx
		fopen [filename]
		cmp rax, -1h
			je error
		mov [filehandle], rax
		fread [filehandle], buffer, buflen
		dec rax
		mov [abuflen], rax
		disp mdone, ldone
		disp buffer, [abuflen]
		
		mov cl,[abuflen]
		mov [cnt1],cl
		a3: mov rsi,buffer
			mov rdi,buffer
			inc rdi
			mov cl,[abuflen]
			dec cl
			mov [cnt2],cl
		a2: mov cl,[rsi]
			mov dl,[rdi]
			cmp cl,dl
			jbe a1
			mov al,cl
			mov cl,dl
			mov dl,al
			mov [rsi],cl
			mov [rdi],dl
		a1:	inc rsi
			inc rdi
			dec byte [cnt2]
			jnz a2
			dec byte [cnt1]
			jnz a3
			
		disp mspace, lspace
		disp msort,lsort
		disp buffer,[abuflen]
		fwrite [filehandle],buffer,[abuflen]
		fclose [filehandle]
		jmp exit

error:
		disp merror,lerror

exit:
		mov rax, 60
		mov rdi, 0
		syscall

section .data
	merror : db " !!! ERROR IN OPENING FILE !!! ",10
	lerror : equ $-merror
	mdone : db "DATA FROM FILE : "
	ldone : equ $-mdone
	msort : db "DATA AFTER SORTING : "
	lsort : equ $-msort
	mspace : db " " ,10
	lspace : equ $-mspace

section .bss
	filename resb 50
	filehandle resb 50
	buffer resb 50
	buflen resb 50
	abuflen resb 50
	cnt1 resb 50
	cnt2 resb 50
	
	
;OUPUT
;vikas@vikas:~$ cd MPL
;vikas@vikas:~/MPL$ nasm -f elf64 -o AssignmentNo8.o AssignmentNo8.nasm
;vikas@vikas:~/MPL$ ld -o AssignmentNo8 AssignmentNo8.o
;vikas@vikas:~/MPL$ ./AssignmentNo8 sort.txt
;DATA FROM FILE : 9 2 1 35  
;DATA AFTER SORTING :     12359vikas@vikas:~/MPL$ 


;DATA FROM FILE sort.txt
;9 2 1 35 
;    12359
