
#编译并写入mbr
nasm -o build/mbr -I ./boot/include/ boot/mbr.S 
dd if=build/mbr of=/home/xt/os/bochs/bin/hd120M.img bs=512 count=1 conv=notrunc

#编译并写入loader
nasm -o build/loader -I ./boot/include/ ./boot/loader.S 
dd if=build/loader of=/home/xt/os/bochs/bin/hd120M.img bs=512 count=4 conv=notrunc seek=2
