# bootloader/Makefile

CC = riscv64-unknown-elf-gcc
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld

bootloader.bin: boot.o
    $(LD) -o bootloader.elf boot.o
    objcopy -O binary bootloader.elf bootloader.bin

boot.o: boot.S
    $(AS) -o boot.o boot.S

clean:
    rm -f *.o bootloader.bin bootloader.elf