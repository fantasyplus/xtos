# 编译并写入mbr
nasm -o build/mbr -I ./boot/include/ boot/mbr.S 
dd if=build/mbr of=../../bochs/bin/hd120M.img bs=512 count=1 conv=notrunc

# 编译并写入loader
nasm -o build/loader -I ./boot/include/ ./boot/loader.S 
dd if=build/loader of=../../bochs/bin/hd120M.img bs=512 count=4 conv=notrunc seek=2

# 编译main
gcc-4.6 -I lib/kernel/ -I lib/ -I kernel/ -c -fno-builtin -o build/main.o -m32 kernel/main.c

# 编译pirnt
nasm -f elf -o build/print.o lib/kernel/print.S

# 编译kernel
nasm -f elf -o build/kernel.o kernel/kernel.S

# 编译interrupt
gcc-4.6 -I lib/kernel/ -I lib/ -I kernel/ -c -fno-builtin -o build/interrput.o -m32 kernel/interrupt.c

# 编译init
gcc-4.6 -m32 -I lib/kernel/ -I lib/ -I kernel/ -c -fno-builtin -o build/init.o kernel/init.c

# 链接成内核
ld -m elf_i386 -Ttext 0x00001500 -e main -o build/kernel.bin  build/main.o build/kernel.o build/init.o build/interrput.o build/print.o

# 写入内核
dd if=build/kernel.bin of=../../bochs/bin/hd120M.img bs=512 count=200 seek=9 conv=notrunc










