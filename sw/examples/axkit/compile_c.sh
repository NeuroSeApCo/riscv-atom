riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32i -nostartfiles -ffreestanding \
../../lib/startup.s ../../lib/stdio.c axkit_demo.c -T ../../lib/link.ld -o out_c.elf
