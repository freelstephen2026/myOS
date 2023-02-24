src=src/bios-puts.c
obj=obj/bios-puts.c.o
flags=-g -Os -march=x86-64 -ffreestanding -Wall
#-Werror

all: $(src) $(obj)

$(obj): $(src)
	gcc -c $(flags) $^ -o $@