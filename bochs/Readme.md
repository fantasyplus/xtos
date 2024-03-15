## 编译步骤(注意改prefix路径)

### depends
```
sudo apt-get install libgtk2.0-dev
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

### make
```
make
make install
```