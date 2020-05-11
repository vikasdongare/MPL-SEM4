;							ASSIGNMENT 5
;ASSIGNMENT STATEMENT:- Write 64-bit ALP to find a)Number of Blank spaces b)Number of lines c)Occurrance of a particular character using FAR procedure and file.

;NAME: VIKAS DONGARE
;CLASS: SE-B
;ROLL NO: 15

global _main
 _main:
%include "macro.nasm"
global proc
extern buffer, abuflen

section .text

proc:
	disp msg4,lmsg4
	accept char, 02
	mov bl, [char]
	mov rsi, buffer
	a2:
		mov al, [rsi]
		cmp al, 0Ah
		je linec
		cmp al, 20h
		je spacec
		cmp al, bl
		je charc
		jmp a1
		
	linec:
		inc byte[linecount]
		jmp a1
		
	spacec:
		inc byte[spacecount]
		jmp a1
		
	charc:
		inc byte[charcount]
		
	a1:
		inc rsi
		dec byte[abuflen]
		jnz a2
	
	disp msg3,lmsg3
	disp msg,lmsg	
	mov rax, [linecount]
	call display
	
	disp msg3,lmsg3
	disp msg1,lmsg1
	mov rax, [spacecount]
	call display
	
	disp msg3,lmsg3
	disp msg2,lmsg2
	mov rax, [charcount]
	call display


	disp msg3,lmsg3
	
ret

display:
	mov rsi,disparr+1
	mov rcx,2
	l4:
		mov rdx,0
		mov rbx,10h
		div rbx

	cmp dl,09h
	jbe l3
	add dl,07h
	l3: 
		add dl,30h
		mov [rsi],dl
		dec rsi
		dec rcx
		jnz l4

	disp disparr,2
ret



section .data

	msg : db " THE NUMBER OF LINES ARE : "
	lmsg : equ $-msg
	msg1 : db " THE NUMBER OF SPACES ARE : "
	lmsg1 : equ $-msg1
	msg2 : db " THE NUMBER OF CHARCTERS YOU WANT ARE : "
	lmsg2 : equ $-msg2
	msg3 : db " ",10
	lmsg3 : equ $-msg3
	msg4 : db " ENTER A CHARCTER : ",10
	lmsg4 : equ $-msg4

section .bss
	char resb 02
	linecount resb 05
	spacecount resb 05
	charcount resb 05
	disparr resb 32
	
	
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

