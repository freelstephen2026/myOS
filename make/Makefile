bin=build/main.bin
img=build/floppy.img
disk=build/disk.qcow2
disk_size=10G
obj=obj/main.s.o obj/bios-puts.c.o
# obj=obj/main.s.o
elf=obj/main.s.elf
ld_script=ld/link.ld
ld_flags=-static -T$(ld_script) -nostdlib -nmagic
# ld_flags=-Ttext 0x7c00 --oformat=binary

all: $(obj) $(bin) $(img) $(disk)

$(elf): $(obj)
	ld $(ld_flags) $^ -o $@

$(bin): $(elf)
	objcopy -O binary $^ $@

$(img): $(bin)
	dd if=/dev/zero of=$@ bs=512 count=2880
	dd if=$^ of=$@
$(disk): $(img)
	qemu-img create -f qcow2 $@ $(disk_size)
	dd if=$(img) of=$@ bs=512 count=1 conv=notrunc