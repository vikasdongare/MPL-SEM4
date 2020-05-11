;							ASSIGNMENT 4
;ASSIGNMENT STATEMENT:- Write menu driven 64-bit ALP to perform Multiplication using a] Successive Addition and b] add and Shift method. 

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

bmenu:
disp menu1,lenm
accept choice,02
mov al,byte[choice]
cmp al,31H
je lchoice1
cmp al,32H
je lchoice2
cmp al,33H
je lchoice3
		
lchoice1:
push ax
disp msg3,len3
pop ax
accept num,03
call convert
mov [no11],al
accept num,03
call convert
mov [no22],al
push ax
disp msg1,len1
pop ax
mov ax,[no11]
mov cx,[no22]
l11: add [res],ax
dec cx
jnz l11
mov ax,[res]
call display
	
jmp bmenu

lchoice2:
push ax
disp msg3,len3
pop ax
accept num,03
call convert
mov [no1],al

accept num,03
call convert

mov [no2],al
mov ax,[no1]

mov bx,[no2]
push ax
disp msg2,len2
pop ax

a2:
shr bx,01
jnc a3
add [result],ax
a3: shl ax,01
cmp ax,0000h
jz a1
cmp bx,0000h
jnz a2
a1: mov ax,[result]
call display

jmp bmenu

lchoice3:
mov rax,60
mov rdi,0
syscall

convert:
mov rsi,num
mov al,[rsi]
cmp al,39h
jle a11
sub al,07h
a11: sub al,30h
rol al,04
mov bl,al
inc rsi
mov al,[rsi]
cmp al,39h
jle a22
sub al,07h
a22: sub al,30h
add al,bl
ret


display:
mov rsi,disparr+3
mov rcx,04
l2:mov rdx,0
mov rbx,10h
div rbx

cmp dl,09h
jbe l1
add dl,07h
l1:add dl,30h
mov [rsi],dl

dec rsi
dec rcx
jnz l2

mov rax,1
mov rdi,1
mov rsi,disparr
mov rdx,4
syscall
ret


section .data
menu1:db 10,"MENU",10
      db"1.USING SUCCESSIVE ADDITION",10
      db"2.USING SHIFT AND ADD",10
      db"3.EXIT",10,10
      db"Enter Your Choice : "
lenm: equ $-menu1
msg1: db 10,"MULTIPLICATION USING SUCCESSIVE ADDITION IS: ",10
len1:equ $-msg1
msg2: db 10,"MULTIPLICATION USING SHIFT AND ADD IS: ",10
len2:equ $-msg2
msg3: db 10,"ENTER A TWO DIGIT NO: ",10
len3:equ $-msg3

result dw 0000h
res dw 0000h
      
section .bss
disparr resb 32
choice resb 02	
no1 resb 08
no2 resb 08
no11 resb 08
no22 resb 08
num resb 05





;OUTPUT
;vikas@vikas:~$ cd MPL
;vikas@vikas:~/MPL$ nasm -f elf64 -o AssignmentNo4.o AssignmentNo4.nasm
;vikas@vikas:~/MPL$ ld -o AssignmentNo4 AssignmentNo4.o 
;vikas@vikas:~/MPL$ ./AssignmentNo4

;MENU
;1.USING SUCCESSIVE ADDITION
;2.USING SHIFT AND ADD
;3.EXIT

;Enter Your Choice : 1

;ENTER A TWO DIGIT NO: 
;10
;12

;MULTIPLICATION USING SUCCESSIVE ADDITION IS: 
;0120
;MENU
;1.USING SUCCESSIVE ADDITION
;2.USING SHIFT AND ADD
;3.EXIT

;Enter Your Choice : 2

;ENTER A TWO DIGIT NO: 
;10
;12

;MULTIPLICATION USING SHIFT AND ADD IS: 
;0120
;MENU
;1.USING SUCCESSIVE ADDITION
;2.USING SHIFT AND ADD
;3.EXIT

;Enter Your Choice : 3
;vikas@vikas:~/MPL$ 

