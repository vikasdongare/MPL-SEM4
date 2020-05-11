;							ASSIGNMENT 2a
;ASSIGNMENT STATEMENT :- Write 64-bit ALP to perform non-overlapped and overlapped block transfer(with and without string instructions).

;NAME: VIKAS DONGARE
;CLASS: SE-B
;ROLL NO: 15


global _start 
_start:

section .text

%macro disp 2 ;use of macro to display statements
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro accept 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro

labels:

	disp menu,lmenu
	accept ch1,02

	mov al,byte[ch1]
	cmp al,31h
	je choice1
	cmp al,32h
	je choice2
	cmp al,33h
	je choice3

choice1:
	disp msga,lena   ;displaying empty message for next line
	disp msg1,len1  ;display message for without string
	mov rsi,sarr     ;point rsi to source array
	mov rdi,darr     ;point rdi to dest array

	l3: mov al,[rsi]   ;intermediate reg since we cannot convert from mem to memory 
		mov [rdi],al
		inc rsi
		inc rdi
		dec byte[cnt1]
		jnz l3

	l4: mov al,[rsi]   ;displaying all the numbers using label
		push rsi           ;after displaying, rsi changes so it is temporarily pushed on stack to regain it later
		call display       ;call display procedure to display one no
		disp msgb,lenb
		pop rsi
		inc rsi
		dec byte[cnt2]
		jnz l4

	disp msga,lena  ;displaying empty message for next line
	disp msga,lena
	jmp labels

choice2:
	disp msga,lena   ;displaying empty message for next line
	disp msg2,len2  ;display the message for with string
	mov rsi,sarr
	mov rdi,darr1
	mov rcx,10
	cld             ;clear direction flag
	rep movsb      ;copying rcx no of times byte by byte

	l5: mov al,[rsi]
		push rsi        ;
		call display
		disp msgb,lenb
		pop rsi
		inc rsi
		dec byte[cnt3]
		jnz l5

	disp msga,lena   ;displaying empty message for next line
	disp msga,lena
	jmp labels

choice3:
	disp msga,lena   ;displaying empty message for next line
	mov rax,60
	mov rdi,0
	syscall


display:
	mov rsi,disparr+1
	mov rcx,2

	l2: mov rdx,0
		mov rbx,10h
		div rbx
		cmp dl,09h
		jbe l1
		cmp dl,07h

	l1: add dl,30h
		mov [rsi],dl
		dec rsi
		dec rcx
		jnz l2

	mov rax,1
	mov rdi,1
	mov rsi,disparr
	mov rdx,2
	syscall
	ret



section .data
sarr db 01h,02h,03h,04h,05h,06h,07h,08h,09h,10h
darr db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
darr1 db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h

cnt1 db 10
cnt2 db 10
cnt3 db 10

msg1: db"Destination Array without using string instruction : "
len1:equ $ -msg1
msga: db"",10
lena:equ $ -msga
msgb: db" "
lenb:equ $ -msgb
msg2: db"Destination Array with using string instruction : "
len2:equ $ -msg2


menu:db"Menu",10
     db"1.Non-overlap(without string)",10
     db"2.Overlap(with string)",10
     db"3.Exit",10
     db"Enter your choice: "
lmenu:equ $ -menu



section .bss
disparr resb 32
ch1  resb 02



;OUTPUT:
;vikas@vikas:~$ cd MPL
;vikas@vikas:~/MPL$ nasm -f elf64 -o AssignmentNo2a.o AssignmentNo2a.nasm
;vikas@vikas:~/MPL$ ld -o AssignmentNo2a AssignmentNo2a.o 
;vikas@vikas:~/MPL$ ./AssignmentNo2a
;Menu
;1.Non-overlap(without string)
;2.Non-overlap(with string)
;3.Exit
;Enter your choice: 1
;
;Destination Array without using string instruction : 01 02 03 04 05 06 07 08 09 10 
;
;Menu
;1.Non-overlap(without string)
;2.Overlap(with string)
;3.Exit
;Enter your choice: 2
;
;Destination Array with using string instruction : 01 02 03 04 05 06 07 08 09 10 
;
;Menu
;1.Non-overlap(without string)
;2.Overlap(with string)
;3.Exit
;Enter your choice: 3

;vikas@vikas:~/MPL$ 

