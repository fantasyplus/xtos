系统调用write的两种实现，分别是模拟调用库函数和直接调用int 0x80接口

编译命令：
``` 
nasm -f elf -o syscall_write.o syscall_write.S
ld -m elf_i386 -o syscall_write.bin syscall_write.o
```