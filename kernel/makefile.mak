# kernel/Makefile

CC = riscv64-unknown-elf-gcc
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld

kernel.elf: entry.o init.o
    $(LD) -o kernel.elf entry.o init.o

entry.o: entry.S
    $(AS) -o entry.o entry.S

init.o: init.c
    $(CC) -c -o init.o init.c

clean:
    rm -f *.o kernel.elf