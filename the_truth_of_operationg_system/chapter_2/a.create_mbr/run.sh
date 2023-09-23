# 编译并写入mbr
nasm -o build/mbr boot/mbr.S 
dd if=build/mbr of=/home/web/xtos/bochs/bin/hd120M.img bs=512 count=1 conv=notrunc