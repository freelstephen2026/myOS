.code16
.text
	.globl _start
_start:
	movw $0x0e, %ah
	movw $97, %al
	int $0x10

	hlt
.halt
	jmp .halt
	ret

bios__putchar:
	#movw $0x0e, %ah
	#movw %di, %al
	#int $0x10
	#movw %al, %ax
	#ret

	movw %di, %ax
	movw $0x0e, %ah

	int $0x10
	movw %
. = _start + 510
.byte 0x55
.byte 0xaa
