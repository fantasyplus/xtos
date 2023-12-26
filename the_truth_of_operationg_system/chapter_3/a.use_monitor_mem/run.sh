nasm -o build/ch3a  boot/mbr.S 
dd if=build/ch3a of=../../bochs/bin/hd120M.img bs=512 count=1 conv=notrunc
