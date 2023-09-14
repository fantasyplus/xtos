                                    ;主引导程序 
                                    ;------------------------------------------------------------
%include "boot.inc"
SECTION MBR vstart=0x7c00         
    mov ax,cs      
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov fs,ax
    mov sp,0x7c00
    mov ax,0xb800
    mov gs,ax

                                    ; 清屏
                                    ;利用0x06号功能，上卷全部行，则可清屏。
                                    ; -----------------------------------------------------------
                                    ;INT 0x10   功能号:0x06	   功能描述:上卷窗口
                                    ;------------------------------------------------------
                                    ;输入：
                                    ;AH 功能号= 0x06
                                    ;AL = 上卷的行数(如果为0,表示全部)
                                    ;BH = 上卷行属性
                                    ;(CL,CH) = 窗口左上角的(X,Y)位置
                                    ;(DL,DH) = 窗口右下角的(X,Y)位置
                                    ;无返回值：
    mov ax, 0600h
    mov bx, 0700h
    mov cx, 0                       ; 左上角: (0, 0)
    mov dx, 184fh		            ; 右下角: (80,25),
				                    ; 因为VGA文本模式中，一行只能容纳80个字符,共25行。
				                    ; 下标从0开始，所以0x18=24,0x4f=79
    int 10h                         ; int 10h

                                    ; 输出字符串:MBR
    mov byte [gs:0x00],'1'
    mov byte [gs:0x01],0x17

    mov byte [gs:0x02],' '
    mov byte [gs:0x03],0x17

    mov byte [gs:0x04],'M'
    mov byte [gs:0x05],0x17	        ;A表示绿色背景闪烁，4表示前景色为红色

    mov byte [gs:0x06],'B'
    mov byte [gs:0x07],0x17

    mov byte [gs:0x08],'R'
    mov byte [gs:0x09],0x17
	 
    mov eax,LOADER_START_SECTOR	    ; 起始扇区lba地址(in disk)
    mov bx,LOADER_BASE_ADDR         ; 写入的地址(in memory)
    mov cx,1			            ; 待读入的扇区数
    call rd_disk_m_16		        ; 以下读取程序的起始部分（一个扇区）
  
    jmp LOADER_BASE_ADDR
       
                                    ;-------------------------------------------------------------------------------
                                    ;功能:读取硬盘n个扇区
rd_disk_m_16:	   
                                    ;-------------------------------------------------------------------------------
				                    ; eax=LBA扇区号
				                    ; ebx=将数据写入的内存地址
				                    ; ecx=读入的扇区数
    mov esi,eax	                    ;备份eax
    mov di,cx		                ;备份cx
                                    ;读写硬盘:
                                    ;第1步：选择特定通道的寄存器，设置要读取的扇区数
    mov dx,0x1f2                    ;先选择通道，往该通道的 sector count 寄存器中写入待操作的扇区数。
    mov al,cl                       ;cl=1(读取的扇区数)
    out dx,al                       ;读取的扇区数

    mov eax,esi	                    ;恢复ax

                                    ;第2步：在特定通道寄存器中放入要读取扇区的地址，将LBA地址存入0x1f3 ~ 0x1f6
                                    ;往该通道上的三个 LBA 寄存器写入扇区起始地址的低 24 位。
                                    ;LBA地址7~0位写入端口0x1f3
    mov dx,0x1f3                     
    out dx,al                       ;al=起始扇区lba地址(0x2),eax=0x00000002

    mov cl,8
                                    ;LBA地址15~8位写入端口0x1f4
    shr eax,cl                      ;logic shift right-> eax>>8,eax=0x00000000
    mov dx,0x1f4
    out dx,al
                                    ;LBA地址23~16位写入端口0x1f5
    shr eax,cl                      ;logic shift right-> eax>>8,eax=0x00000000
    mov dx,0x1f5
    out dx,al

    shr eax,cl                      ;logic shift right-> eax>>8,eax=0x00000000
    and al,0x0f	                    ;lba第24~27位(aka device reg's 0-3bit),keep al's low 4 bits to write lba 24-27bits
    or al,0xe0	                    ;设置4-7位为1110,表示lba模式(4bit:0 for primary,1 for secondary;6bit:0 for chs mode,1 for lba mode)
    mov dx,0x1f6                    ;device register
    out dx,al

                                    ;第3步：向0x1f7端口写入读命令，0x20 
    mov dx,0x1f7                    ;command register(when out,0x1f7 is command register)
    mov al,0x20                        
    out dx,al

                                    ;第4步：检测硬盘状态
.not_ready:                         ;读取该通道上的 status 寄存器，判断硬盘工作是否完成。
                                    ;同一端口，写时表示写入命令字，读时表示读入硬盘状态
    nop                             ;do nothing
    in al,dx                        ;read status info from status register(when in,0x1f7 is status register)
    and al,0x88	                    ;第4位为1表示硬盘控制器已准备好数据传输，第7位为1表示硬盘忙
    cmp al,0x08                     ;cmp 指令会影响的标志位有 ZF CF PF 等，这里咱们借助 ZF 位来判断 cmp 的结果。
    jnz .not_ready	                ;若未准备好，继续等。

                                    ;第5步：从0x1f0端口读数据
    mov ax, di                      ;di当中存储的是要读取的扇区数
    mov dx, 256                     ;每个扇区512字节，一次读取两个字节，所以一个扇区就要读取256次，与扇区数相乘，就等得到总读取次数
    mul dx                          ;被乘数隐含al或ax寄存器,注意：16位乘法会改变dx的值！！！！
    mov cx, ax	                    ; 得到了要读取的总次数，然后将这个数字放入cx中
    mov dx, 0x1f0                   ;0x1fo data register
.go_on_read:
    in ax,dx
    mov [bx],ax
    add bx,2		  
    loop .go_on_read                ;loop count is in cx register
    ret                             ;ret 指令将战中的返回地址重新加载到程序计数器中，如 CS: ip
                                    ;return to line55
    times 510-($-$$) db 0
    db 0x55,0xaa
