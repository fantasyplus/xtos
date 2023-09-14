%include "boot.inc"
section loader vstart=LOADER_BASE_ADDR

                                    ;print "2 LOADER"
mov byte [gs:0x0a],'2'
mov byte [gs:0x0b],0x17             

mov byte [gs:0x0c],' '
mov byte [gs:0x0d],0x17

mov byte [gs:0x0e],'L'
mov byte [gs:0x0f],0x17   

mov byte [gs:0xa0],'O'
mov byte [gs:0xa1],0x17

mov byte [gs:0xa2],'A'
mov byte [gs:0xa3],0x17

mov byte [gs:0xa4],'D'
mov byte [gs:0xa5],0x17

mov byte [gs:0xa6],'E'
mov byte [gs:0xa7],0x17

mov byte [gs:0xa8],'R'
mov byte [gs:0xa9],0x17

jmp $		                        ; 通过死循环使程序悬停在此

