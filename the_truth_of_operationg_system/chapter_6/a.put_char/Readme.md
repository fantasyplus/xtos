# 关于为什么put_char位置打印不在屏幕左上角的原因
    
-    因为光标寄存器的位置就在这里

-    BIOS运行阶段的时候也有信息显示，就把光标寄存器的位置顶到这里来了

-    所以你通过获取光标寄存器的光标位置来打印，自然就是显示在这里

-    至于为什么1MBR是左上角，是因为1MBR是直接操作显存显示的，我们操作的那几个显存空间就是对应的左上角起始位置

-    我们通过操作显存显示的字符，并没有改变光标寄存器的值，也就是没有改变光标位置

