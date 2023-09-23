C语言和汇编语言混合编程

编译命令：
```
gcc-4.6 -o C.o -c -m32 C.c
nasm -f elf -o S.o S.s
ld -m elf_i386 -o C_with_S_print.bin C.o S.o
```