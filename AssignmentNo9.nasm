;							ASSIGNMENT 9
;ASSIGNMENT STATEMENT:- Write a 64 bit ALP to switch from real to protected mode and display the values of :GDTR, LDTR, IDTR, TR and MSW Registers.

;NAME: VIKAS DONGARE 
;CLASS: SE-B
;ROLL NO: 15

global _start
_start:

%include "macro.nasm"

section .text
smsw eax
mov [cr0_data],eax
bt eax,00
jc protected_mode
print m1,l1
jmp exit

protected_mode:
print m2,l2
mov ax,[cr0_data+2]
call display
mov ax,[cr0_data]
call display

print m3,l3
sgdt [gdt_data]
mov ax,[gdt_data+4]
call display
mov ax,[gdt_data+2]
call display
mov ax,[gdt_data]
call display

print m4,l4
sidt [idt_data]
mov ax,[idt_data+4]
call display
mov ax,[idt_data+2]
call display
mov ax,[idt_data]
call display

print m5,l5
sldt [ldt_data]
mov ax,[ldt_data]
call display

print m6,l6
str [tr_data]
mov ax,[tr_data]
call display

exit:
mov rax,60
mov rdi,0
syscall

display:
mov rsi,disparr+3
mov rcx,04
a5:
mov rdx,0
mov rbx,10h
div rbx

cmp dl,09h
jbe a6
add dl,07h

a6:add dl,30h
mov [rsi],dl
dec rsi
dec rcx
jnz a5

mov rax,1
mov rdi,1
mov rsi,disparr
mov rdx,04
syscall
ret

section .data
m1: db 10,"In real mode"
l1:equ $-m1
m2: db 10 ,"MSW:"
l2:equ $-m2
m3: db 10, "GDTR:"
l3:equ $-m3
m4: db 10, "IDTR:"
l4:equ $-m4
m5: db 10 ,"LDTR:"
l5:equ $-m5
m6: db 10 ,"TR:"
l6:equ $-m6

section .bss
cr0_data resb 32
gdt_data resb 48
ldt_data resb 16
idt_data resb 48
tr_data resb 16
disparr resb 50




