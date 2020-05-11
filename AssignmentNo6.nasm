;							ASSIGNMENT 6
;ASSIGNMENT STATEMENT:- Write 64-bit menu driven ALP to implement OS commands TYPE, COPY and DELETE using file. 

;NAME: VIKAS DONGARE
;CLASS: SE-B
;ROLL NO: 15

global _start
 _start:
%include "macro.nasm"

section .text

menn:
	disp msg,lmsg
	disp menu,lmenu
	accept choice,2
	disp msg,lmsg

	mov al,byte[choice]
	cmp al,31h
		je typec
	cmp al,32h
		je copyc
	cmp al,33h
		je deletec
		jmp exit

typec:
		pop rcx ; no of arguments
		pop rcx ;	programme name
		pop rcx ;	filename
		mov [filename1],rcx
		fopen [filename1]
		cmp rax, -1h
			je error
		mov [filehandle1], rax
		fread [filehandle1], buffer, buflen
		dec rax
		mov [abuffer], rax
		disp buffer, [abuffer]
		jmp menn

copyc:
		pop rcx
		mov [filename2], rcx
		fopen [filename2]
		cmp rax, -1h
			je error
		mov [filehandle2], rax
		fwrite [filehandle2], buffer, [abuffer]
		fclose [filehandle1]
		fclose [filehandle2]
		disp msg1,lmsg1
		jmp menn

deletec:
		fdelete [filename1]
		disp msg2,lmsg2
		jmp menn
	
error:
		disp merror,lerror

exit:
		mov rax,60
		mov rdi,0
		syscall

section .data
	menu : db "---> MENU <---",10
			db " 1] DISPLAY FILE CONTENTS ",10
			db " 2] COPY TO ANOTHER FILE",10
			db " 3] DELETE FILE",10
			db " 4] EXIT ",10
			db "ENTER YOUR CHOICE : "
	lmenu : equ $-menu
	msg : db" ",10
	lmsg : equ $-msg
	merror : db " !!! ERROR IN OPENING FILE !!! ",10
	lerror : equ $-merror
	msg1: db " !!! CONTENT SUCCESSFULLY COPIED !!!",10
	lmsg1: equ $-msg1
	msg2: db " !!! FILE DELETED SUCCESSFULLY !!!",10
	lmsg2: equ $-msg2

section .bss
	filehandle1 resb 50
	filehandle2 resb 50
	filename1 resb 50
	filename2 resb 50
	buffer resb 50
	buflen resb 50
	abuffer resb 50
	choice resb 03
	
	

;OUTPUT
;vikas@vikas:~$ cd MPL
;vikas@vikas:~/MPL$ nasm -f elf64 -o AssignmentNo6.o AssignmentNo6.nasm
;vikas@vikas:~/MPL$ ld -o AssignmentNo6 AssignmentNo6.o 
;vikas@vikas:~/MPL$ ./AssignmentNo6 t1.txt t2.txt
 
;---> MENU <---
; 1] DISPLAY FILE CONTENTS 
; 2] COPY TO ANOTHER FILE
; 3] DELETE FILE
; 4] EXIT 
;ENTER YOUR CHOICE : 1
; 
;hello
;hiiii 
;---> MENU <---
; 1] DISPLAY FILE CONTENTS 
; 2] COPY TO ANOTHER FILE
; 3] DELETE FILE
; 4] EXIT 
;ENTER YOUR CHOICE : 2
; 
; !!! CONTENT SUCCESSFULLY COPIED !!!
; 
;---> MENU <---
; 1] DISPLAY FILE CONTENTS 
; 2] COPY TO ANOTHER FILE
; 3] DELETE FILE
; 4] EXIT 
;ENTER YOUR CHOICE : 3
; 
; !!! FILE DELETED SUCCESSFULLY !!!
; 
;---> MENU <---
; 1] DISPLAY FILE CONTENTS 
; 2] COPY TO ANOTHER FILE
; 3] DELETE FILE
; 4] EXIT 
;ENTER YOUR CHOICE : 4
; 
;vikas@vikas:~/MPL$ 

