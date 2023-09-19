                                    ;���������� 
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

                                    ; ����
                                    ;����0x06�Ź��ܣ��Ͼ�ȫ���У����������
                                    ; -----------------------------------------------------------
                                    ;INT 0x10   ���ܺ�:0x06	   ��������:�Ͼ�����
                                    ;------------------------------------------------------
                                    ;���룺
                                    ;AH ���ܺ�= 0x06
                                    ;AL = �Ͼ�������(���Ϊ0,��ʾȫ��)
                                    ;BH = �Ͼ�������
                                    ;(CL,CH) = �������Ͻǵ�(X,Y)λ��
                                    ;(DL,DH) = �������½ǵ�(X,Y)λ��
                                    ;�޷���ֵ��
    mov ax, 0600h
    mov bx, 0700h
    mov cx, 0                       ; ���Ͻ�: (0, 0)
    mov dx, 184fh		            ; ���½�: (80,25),
				                    ; ��ΪVGA�ı�ģʽ�У�һ��ֻ������80���ַ�,��25�С�
				                    ; �±��0��ʼ������0x18=24,0x4f=79
    int 10h                         ; int 10h

                                    ; ����ַ���:MBR
    mov byte [gs:0x00],'1'
    mov byte [gs:0x01],0x17

    mov byte [gs:0x02],' '
    mov byte [gs:0x03],0x17

    mov byte [gs:0x04],'M'
    mov byte [gs:0x05],0x17	        ;A��ʾ��ɫ������˸��4��ʾǰ��ɫΪ��ɫ

    mov byte [gs:0x06],'B'
    mov byte [gs:0x07],0x17

    mov byte [gs:0x08],'R'
    mov byte [gs:0x09],0x17
	 
    mov eax,LOADER_START_SECTOR	    ; ��ʼ����lba��ַ(in disk)
    mov bx,LOADER_BASE_ADDR         ; д��ĵ�ַ(in memory)
    mov cx,1			            ; �������������
    call rd_disk_m_16		        ; ���¶�ȡ�������ʼ���֣�һ��������
  
    jmp LOADER_BASE_ADDR
       
                                    ;-------------------------------------------------------------------------------
                                    ;����:��ȡӲ��n������
rd_disk_m_16:	   
                                    ;-------------------------------------------------------------------------------
				                    ; eax=LBA������
				                    ; ebx=������д����ڴ��ַ
				                    ; ecx=�����������
    mov esi,eax	                    ;����eax
    mov di,cx		                ;����cx
                                    ;��дӲ��:
                                    ;��1����ѡ���ض�ͨ���ļĴ���������Ҫ��ȡ��������
    mov dx,0x1f2                    ;��ѡ��ͨ��������ͨ���� sector count �Ĵ�����д�����������������
    mov al,cl                       ;cl=1(��ȡ��������)
    out dx,al                       ;��ȡ��������

    mov eax,esi	                    ;�ָ�ax

                                    ;��2�������ض�ͨ���Ĵ����з���Ҫ��ȡ�����ĵ�ַ����LBA��ַ����0x1f3 ~ 0x1f6
                                    ;����ͨ���ϵ����� LBA �Ĵ���д��������ʼ��ַ�ĵ� 24 λ��
                                    ;LBA��ַ7~0λд��˿�0x1f3
    mov dx,0x1f3                     
    out dx,al                       ;al=��ʼ����lba��ַ(0x2),eax=0x00000002

    mov cl,8
                                    ;LBA��ַ15~8λд��˿�0x1f4
    shr eax,cl                      ;logic shift right-> eax>>8,eax=0x00000000
    mov dx,0x1f4
    out dx,al
                                    ;LBA��ַ23~16λд��˿�0x1f5
    shr eax,cl                      ;logic shift right-> eax>>8,eax=0x00000000
    mov dx,0x1f5
    out dx,al

    shr eax,cl                      ;logic shift right-> eax>>8,eax=0x00000000
    and al,0x0f	                    ;lba��24~27λ(aka device reg's 0-3bit),keep al's low 4 bits to write lba 24-27bits
    or al,0xe0	                    ;����4-7λΪ1110,��ʾlbaģʽ(4bit:0 for primary,1 for secondary;6bit:0 for chs mode,1 for lba mode)
    mov dx,0x1f6                    ;device register
    out dx,al

                                    ;��3������0x1f7�˿�д������0x20 
    mov dx,0x1f7                    ;command register(when out,0x1f7 is command register)
    mov al,0x20                        
    out dx,al

                                    ;��4�������Ӳ��״̬
.not_ready:                         ;��ȡ��ͨ���ϵ� status �Ĵ������ж�Ӳ�̹����Ƿ���ɡ�
                                    ;ͬһ�˿ڣ�дʱ��ʾд�������֣���ʱ��ʾ����Ӳ��״̬
    nop                             ;do nothing
    in al,dx                        ;read status info from status register(when in,0x1f7 is status register)
    and al,0x88	                    ;��4λΪ1��ʾӲ�̿�������׼�������ݴ��䣬��7λΪ1��ʾӲ��æ
    cmp al,0x08                     ;cmp ָ���Ӱ��ı�־λ�� ZF CF PF �ȣ��������ǽ��� ZF λ���ж� cmp �Ľ����
    jnz .not_ready	                ;��δ׼���ã������ȡ�

                                    ;��5������0x1f0�˿ڶ�����
    mov ax, di                      ;di���д洢����Ҫ��ȡ��������
    mov dx, 256                     ;ÿ������512�ֽڣ�һ�ζ�ȡ�����ֽڣ�����һ��������Ҫ��ȡ256�Σ�����������ˣ��͵ȵõ��ܶ�ȡ����
    mul dx                          ;����������al��ax�Ĵ���,ע�⣺16λ�˷���ı�dx��ֵ��������
    mov cx, ax	                    ; �õ���Ҫ��ȡ���ܴ�����Ȼ��������ַ���cx��
    mov dx, 0x1f0                   ;0x1fo data register
.go_on_read:
    in ax,dx
    mov [bx],ax
    add bx,2		  
    loop .go_on_read                ;loop count is in cx register
    ret                             ;ret ָ�ս�еķ��ص�ַ���¼��ص�����������У��� CS: ip
                                    ;return to line55
    times 510-($-$$) db 0
    db 0x55,0xaa