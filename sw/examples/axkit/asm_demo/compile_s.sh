riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32i -nostartfiles -ffreestanding -nostdlib \
../../../lib/startup.s axkit_demo.S -D__ASSEMBLY__ -T ../../../lib/link.ld -o out_s.elf