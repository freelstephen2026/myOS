.code16
.text
	.globl _start
_start:
	#set up segment registers
	xor %ax, %ax
	mov %ax, %ds
	mov %ax, %es
	movw %ax, %ss
	movw $0x7c00, %sp
	mov $message__reg_setup_done, %di
	call bios_print

	#find the port for the sata register

	#keeps everything running
	hlt
.halt:
	jmp .halt
	ret

message__reg_setup_done:
	.string "myOS -- bootloader\n------------------\nsegment registers and stack pointer are set up\n"
	.byte 0


bios_print:
	#pointer to current char goes in %bx
	#return value is in %rax
	movw $0, %ax
	movw %di, %bx
	cmp $0, %di    # Check if %ax is 0 (null)
	je .finish_bios_print
	
.next_char:
	#current char is in %cx
	movb (%bx), %cl
	cmp $0, %cx    # Check if %bx is 0 (null)
	je .finish_bios_print
	
	movw %cx, %di
	call bios_putchar

	inc %bx
	
	jmp .next_char

.finish_bios_print:
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

get_sata_port: