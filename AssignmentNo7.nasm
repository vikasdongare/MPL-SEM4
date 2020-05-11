;							ASSIGNMENT 7
;ASSIGNMENT STATEMENT:- Write 64 bit ALP to find factorial of given integer number.

;NAME: VIKAS DONGARE
;CLASS: SE-B
;ROLL NO: 15

global _start
_start:

section .text

%macro accept 2
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro disp 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

	disp msg2,lmsg2
	disp msg,lmsg
	accept num,03
	call convert	
	cmp al,01
	ja v1
	disp msg1,lmsg1
	jmp v2

	
	v1:
		mov rcx,rax
		dec rcx
	v3:
		push rax
		dec rax
		cmp rax,01h
		ja v3
	v4:
		pop rbx
		mul rbx
		dec rcx
		jnz v4
		
		push rax
		disp msg2,lmsg2
		disp ms,lms
		pop rax
		
		call display
	v2:
		mov rax,60
		mov rdi,0
		syscall

display:
mov rsi,disparr+3
mov rcx,4
l4:
mov rdx,0
mov rbx,10h
div rbx

cmp dl,09h
jbe l3
add dl,07h
l3: add dl,30h
mov [rsi],dl
dec rsi
dec rcx
jnz l4

disp disparr,4

convert:
	mov rsi,num
	mov al,[rsi]
	cmp al,39h
	jle a5
	sub al,07h
	
	a5:
		sub al,30h
		rol al,04
		mov bl,al
		inc rsi
		
	mov al,[rsi]
	cmp al,39h
	jle a2
	sub al,07h
	
	a2:
		sub al,30h
		add al,bl
		ret

section .data
	msg : db"Enter Number : "
	lmsg : equ $-msg
	msg1 : db"The factorial : 1 ",10
	lmsg1 : equ $-msg1
	ms : db"The Factorial : "
	lms : equ $-ms
	msg2:db"  ",10
	lmsg2:equ $-msg2

section .bss
	num resb 03
	disparr resb 32
