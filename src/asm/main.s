.code16
.text
	.globl _start
_start:
	movw $0x7c00, %sp

	movb $0x0e, %ah
	movb $'a', %al
	int $0x10

	movb $0x0e, %ah
	movb $'a', %al
	int $0x10

	movw $0xa, %di
	###################################
	movw %di, %ax
    
    movb $0x0e, %ah
    int $0x10

	movw $0x000d, %ax
	movb $0x0e, %ah
	int $0x10
    
    # Newline printed, return without printing whitespace
	###################################

	movb $0x0e, %ah
	movb $'b', %al
	int $0x10

	movw $0xa, %di
	call bios_putchar

	hlt
.halt:
	jmp .halt
	ret

bios_putchar:
	movw %di, %ax
	movb $0x0e, %ah
	int $0x10

	cmpb $0xa, %al
	je .carraige_return

	jmp .bios_putchar_return
.carraige_return:
	movw $0x000d, %ax
	movb $0x0e, %ah
	int $0x10
.bios_putchar_return:
	movw %di, %ax
	ret

_1bios__putchar:
    movw %di, %ax
	andb $0xff, %al
    
    movb $0x0e, %ah
    int $0x10

    # Check if character is a newline
    cmpb $0xa, %al
    jne .done
    
    # Newline printed, return without printing whitespace
    ret
.done:
    movw %di, %ax
    ret


_bios__putchar:
	#move %di's lower 8 bits into %al
	movw %di, %ax
	andb $0xff, %al
	# 0x0E in %ah tells BIOS to print the character
	movb $0x0e, %ah
	int $0x10
	movw %di, %ax
	ret

. = _start + 510
.byte 0x55
.byte 0xaa
