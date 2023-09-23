section .data
str: db "asm_print says hello world" ,0xa,0
;0xa是换行符，0是手工加上的字符串结束符\0的ASCII码
str_len: equ $-str

section .text
extern c_print
global _start
_start:;程序入口
    ;调用c_print函数
    push str;压入c_print的参数
    call c_print
    add esp,4

    ;退出程序
    mov eax,1
    int 0x80

;这个函数声明在C，在汇编中实现，但是在C中调用
global asm_print 
asm_print:
    push ebp
    mov ebp,esp
    mov eax,4
    mov ebx,1
    mov ecx,[ebp+8]
    mov edx,[ebp+12]
    int 0x80
    pop ebp
    ret