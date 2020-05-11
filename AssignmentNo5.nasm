;							ASSIGNMENT 5
;ASSIGNMENT STATEMENT:- Write 64-bit ALP to find a)Number of Blank spaces b)Number of lines c)Occurrance of a particular character using FAR procedure and file.

;NAME: VIKAS DONGARE
;CLASS: SE-B
;ROLL NO: 15

global _start
 _start:
%include "macro.nasm"
global buffer, abuflen
extern proc


section .text

	pop rcx
	pop rcx
	pop rcx
	mov [filename], rcx
	fopen [filename]
	cmp rax, -1h
	je error
	mov [filehandle], rax
	fread [filehandle], buffer, buflen
	dec rax
	mov [abuflen], rax
	call proc
	fclose [filename]
	jmp exit
	
error:
		disp merror,lerror

exit:
		mov rax,60
		mov rdi,0
		syscall
		
section .data
	
	
	merror : db " !!! ERROR IN OPENING FILE !!! ",10
	lerror : equ $-merror
	

section .bss
	filehandle resb 50
	filename resb 50
	buffer resb 50
	buflen resb 50
	abuflen resb 50
	
;OUTPUT
;vikas@vikas:~$ cd MPL
;vikas@vikas:~/MPL$ nasm -f elf64 -o AssignmentNo5.o AssignmentNo5.nasm
;vikas@vikas:~/MPL$ nasm -f elf64 -o AssignmentNo5_1.o AssignmentNo5_1.nasm
;vikas@vikas:~/MPL$ ld -o AssignmentNo5 AssignmentNo5.o AssignmentNo5_1.o
;vikas@vikas:~/MPL$ ./AssignmentNo5 AssignmentNo5.txt
; ENTER A CHARCTER : 
;E
 
; THE NUMBER OF LINES ARE : 01 
; THE NUMBER OF SPACES ARE : 0B 
; THE NUMBER OF CHARCTERS YOU WANT ARE : 02 
;vikas@vikas:~/MPL$ 

;DATA OF THE FILE - assign5.txt
;Hii, I am from KKWIEER and I am a resident of NASHIK

