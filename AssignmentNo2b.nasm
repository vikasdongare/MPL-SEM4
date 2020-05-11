;						ASSIGNMENT 2b
;ASSIGNMENT STATEMENT :- Write 64-bit ALP to perform non-overlapped and overlapped block transfer(with and without string instructions).

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
mov rdi,%2
syscall
%endmacro

%macro print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

menu:
print menu1,ml
accept choice1,2
mov al,byte[choice1]
cmp al,31H
je lchoice1
cmp al,32H
je lchoice2
cmp al,33H
je lchoice3

lchoice1:      
print msg1,len1
mov rsi,oarr
d1:
mov rax,[rsi]
push rsi
call display
print msg3,len3
pop rsi
inc rsi
dec byte[cnt1]
jnz d1

mov rsi,oarr
mov rdi,oarr
add rsi,09
add rdi,13
d2:
mov al,[rsi]
mov [rdi],al
dec rsi
dec rdi
dec byte[cnt]
jnz d2

print msg2,len2
mov rsi,oarr
d3:
mov rax,[rsi]
push rsi
call display
print msg3,len3
pop rsi
inc rsi
dec byte[cnt2]
jnz d3

jmp menu

lchoice2:
print msg1,len1
mov rsi,oarr
d4:
mov rax,[rsi]
push rsi
call display
print msg3,len3
pop rsi
inc rsi
dec byte[cnt3]
jnz d4
std
mov rsi,oarr
mov rdi,oarr

add rsi,09
add rdi,13
mov rcx,0AH
rep movsb

print msg2,len2
mov rsi,oarr
d5:
mov rax,[rsi]
push rsi
call display
print msg3,len3
pop rsi
inc rsi
dec byte[cnt4]
jnz d5

jmp menu

lchoice3:
mov rax,60
mov rdi,0
syscall

display:
mov rsi,disparr+1
mov rcx,02
l2:
mov rdx,0
mov rbx,10h
div rbx

cmp dl,30h
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
mov rdx,02
syscall
ret

section .data
oarr db 01H,02H,03H,04H,05H,06H,07H,08H,09H,01H,02H,03H,04H,05H,06H

cnt db 10
cnt1 db 15
cnt2 db 15
cnt3 db 15
cnt4 db 15
msg1: db 10,"Initial array:",10
len1:equ $-msg1
msg2: db 10,"Second array:",10
len2:equ $-msg2
msg3: db " "
len3:equ $-msg3
menu1 db 10,"1.Overlap without string function",10
      db "2.Overlap with string function",10
      db "3.Exit",10
      db "Enter your choice:"
ml:equ $-menu1      

section .bss
disparr resb 16 
choice1 resb 02



;OUTPUT:
;vikas@vikas:~$ cd MPL
;vikas@vikas:~/MPL$ nasm -f elf64 -o AssignmentNo2b.o AssignmentNo2b.nasm
;vikas@vikas:~/MPL$ ld -o AssignmentNo2b AssignmentNo2b.o 
;vikas@vikas:~/MPL$ ./AssignmentNo2b

;1.Overlap without string function
;2.Overlap with string function
;3.Exit
;Enter your choice:1

;Initial array:
;01 02 03 04 05 06 07 08 09 01 02 03 04 05 06 
;Second array:
;01 02 03 04 01 02 03 04 05 06 07 08 09 01 06 
;1.Overlap without string function
;2.Overlap with string function
;3.Exit
;Enter your choice:2

;Initial array:
;01 02 03 04 01 02 03 04 05 06 07 08 09 01 06 
;Second array:
;01 02 03 04 01 02 03 04 01 02 03 04 05 06 06 
;1.Overlap without string function
;2.Overlap with string function
;3.Exit
;Enter your choice:3
vikas@vikas:~/MPL$ 
