.code16
.text
	.globl _start
_start:
	movw $0x7c00, %sp

	movw $'x', %di
	call bios_putchar

	movw $0xa, %di
	call bios_putchar

	movw $'h', %di
	call bios_putchar

	mov $str2, %di
	call bios_print

	hlt
.halt:
	jmp .halt
	ret

str:
	.string "hi"
	.byte 0

str2:
	.byte 'h','i',0x0

bios_print:
	#pointer to current char goes in %bx
	#return value is in %rax
	movw $0, %ax
	movw %di, %bx
	cmp $0, %di    # Check if %ax is 0 (null)
	je .finish_bios_print
	
.next_char:
	#current char is in %cx
	movw (%bx), %cx
	cmp $0, %cx    # Check if %bx is 0 (null)
	je .finish_bios_print
	
	movw %cx, %di
	call bios_putchar

	inc %bx
	
	jmp .next_char

.finish_bios_print:
	movw $'X', %di
	call bios_putchar
	movw %ax, %ax
	ret


bios_putchar:
	pushw %ax
	movw %di, %ax
	movb $0x0e, %ah
	int $0x10

	cmpb $0xa, %al
	je .carraige_return

	popw %ax

	jmp .bios_putchar_return
.carraige_return:
	movw $0x000d, %ax
	movb $0x0e, %ah
	int $0x10
	popw %ax
	jmp .bios_putchar_return
.bios_putchar_return:
	movw %di, %ax
	ret