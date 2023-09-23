extern void asm_print(char*,int);

//c_print这个函数是在汇编中实现的
void c_print(char* str){
    int len=0;
    while(str[len++]);
    asm_print(str,len);
}