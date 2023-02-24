src=src/asm/main.s
obj=obj/main.s.o
img=build/floppy.img

ld_flags=-Ttext 0x7c00 --oformat=binary

all: $(obj)
$(obj): $(src)
	as $^ -o $@