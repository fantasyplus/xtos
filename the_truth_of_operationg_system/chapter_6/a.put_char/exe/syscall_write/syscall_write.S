section .data
str_c_lib: db "c library says:hello world!",0xa
str_c_lib_len: equ $-str_c_lib

str_syscall: db "syscall says:hello world!",0xa
str_syscall_len: equ $-str_syscall

section .text
global _start
_start:
    ;模拟c语言中系统调用库函数write
    push str_c_lib_len
    push str_c_lib
    push 1

    call simu_c_write
    add esp,12

    ;跨过库函数，直接调用系统调用
    mov eax,4 ;第4号系统调用为write
    mov ebx,1
    mov ecx,str_syscall
    mov edx,str_syscall_len
    int 0x80

    ;退出
    mov eax,1 ;第1号系统调用为exit
    int 0x80
simu_c_write:
    push ebp
    mov ebp,esp
    mov eax,4
    mov ebx,[ebp+8]
    mov ecx,[ebp+12]
    mov edx,[ebp+16]
    int 0x80
    pop ebp
    ret

