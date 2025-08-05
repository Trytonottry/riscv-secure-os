#!/bin/bash

# Build bootloader
cd bootloader
make
cd ..

# Build kernel
cd kernel
make
cd ..

# Run QEMU
qemu-system-riscv64 -machine virt -nographic -bios default -kernel bootloader/bootloader.elf