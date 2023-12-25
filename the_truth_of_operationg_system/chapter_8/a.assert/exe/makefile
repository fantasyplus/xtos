.PHONY:all

# print.o:print.c
# 	gcc -c -o print.o print.c 
# main.o:main.c
# 	gcc -c -o main.o main.c

%.o:%.c

obj=print.o main.o

123.out:$(obj)
	gcc -o $@ $^

all:123.out
	@echo "start compile"