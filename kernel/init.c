// kernel/init.c

#include "uart.h"

void kernel_init() {
    uart_init();
    uart_puts("Kernel initialized...\n");
}