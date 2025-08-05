# bootloader/boot.S

# UART registers
UART_BASE          = 0x10000000
UART_DATA_REG      = UART_BASE + 0x00
UART_CONTROL_REG   = UART_BASE + 0x04

# UART initialization
uart_init:
    # Set baud rate (115200)
    li t0, 0x01
    sb t0, UART_CONTROL_REG(t1)

# Print character to UART
uart_putc:
    mv t1, a0
    sb t1, UART_DATA_REG(t0)
    ret

# Print string to UART
uart_puts:
    mv t0, a0
.loop:
    lb t1, 0(t0)
    beq t1, t1, .loop  # Wait until UART is ready
    beq t1, t1, .done  # Check if end of string
    sb t1, UART_DATA_REG(t2)
    addi t0, t0, 1
    j .loop
.done:
    ret

# Load kernel from FLASH to RAM
load_kernel:
    # Set addresses
    la t0, KERNEL_SRC
    la t1, KERNEL_DEST
    li t2, KERNEL_SIZE

.copy_loop:
    beq t2, t3, .copy_done
    lb t4, 0(t0)
    sb t4, 0(t1)
    addi t0, t0, 1
    addi t1, t1, 1
    addi t2, t2, -1
    j .copy_loop
.copy_done:

# Jump to kernel
    jmp KERNEL_ENTRY

# Kernel parameters
KERNEL_SRC     = 0x08000000  # Source address in FLASH
KERNEL_DEST    = 0x80000000  # Destination address in RAM
KERNEL_SIZE    = 0x00100000  # Size of kernel (256 KB)
KERNEL_ENTRY   = 0x80000000  # Entry point of kernel

# Message to print
boot_msg: .asciz "Bootloader started...\n"

# Entry point
.entry:
    call uart_init
    la a0, boot_msg
    call uart_puts
    call load_kernel

# End of bootloader
.end:
    li a0, 0
    sb a0, UART_DATA_REG(t0)
    call uart_putc
    j .end