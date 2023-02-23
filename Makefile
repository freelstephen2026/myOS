src=src/asm/main.s
obj=obj/test.o
bin=build/test.bin
img=build/floppy.img

ld_flags=-Ttext 0x7c00 --oformat=binary

all: $(obj) $(bin) $(img)
$(obj): $(src)
	as $^ -o $@

$(bin): $(obj)
	ld $(ld_flags) $^ -o $@

$(img): $(bin)
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=$^ of=$@