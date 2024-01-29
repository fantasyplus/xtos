## 编译步骤(注意改prefix路径)
### configure
```
./configure \
--prefix=/home/web/xtos/bochs \
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