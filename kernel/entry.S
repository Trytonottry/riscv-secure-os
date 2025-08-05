# kernel/entry.S

.section .text
.globl _start
_start:
    # Initialize stack pointer
    la sp, stack_top

    # Call kernel initialization
    call kernel_init

    # Halt the CPU
    halt:
        wfi
        j halt

.section .bss
.align 2
stack:
    .space 4096
stack_top: