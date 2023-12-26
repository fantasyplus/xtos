# 编译并写入mbr
nasm -o build/mbr -I ./boot/include/ boot/mbr.S 
dd if=build/mbr of=../../bochs/bin/hd120M.img bs=512 count=1 conv=notrunc

# 编译并写入loader
nasm -o build/loader -I ./boot/include/ ./boot/loader.S 
dd if=build/loader of=../../bochs/bin/hd120M.img bs=512 count=4 conv=notrunc seek=2

# 编译mian
gcc-4.6 -o build/main.o -c -m32 -I lib/kernel/ kernel/main.c

# 编译pirnt
nasm -f elf -o build/print.o lib/kernel/print.S

# 链接成内核
ld -m elf_i386 -Ttext 0x00001500 -e main -o build/kernel.bin  build/main.o build/print.o

# 写入内核
dd if=build/kernel.bin of=../../bochs/bin/hd120M.img bs=512 count=200 conv=notrunc seek=9
