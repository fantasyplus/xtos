## 编译步骤(注意改prefix路径)

### depends
```
sudo apt-get install libgtk2.0-dev
<<<<<<< HEAD:bochs/Readme.md
sudo apt-get install gnome-devel
=======
>>>>>>> 15de0685c4194ac710ea113adcd2ae2c7d4e0f09:bochs/Readme.Md
```

### configure
```
./configure \
--prefix=/home/xt/xtos/bochs \
--enable-debugger \
--enable-disasm \
--enable-iodebug \
--enable-x86-debugger \
--with-x \
--with-x11
```

### before make
在source的makefile的92行最后，添加 -lpthread

### make
```
make
make install
```