make -f make/bios-puts.c.o.mk
make -f make/main.s.o.mk
make -f make/Makefile
# qemu-system-x86_64 -fda build/floppy.img
qemu-system-x86_64 -hda build/disk.qcow2