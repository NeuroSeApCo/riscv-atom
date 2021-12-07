echo "Step-1: Generating input imge header..."
octave --no-gui --eval "image2header"

echo "Step-2: Compiling code with header..."
#gcc -Wall impr.c -o impr.out
riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32i -nostartfiles \
../../../lib/startup.s ../../../lib/stdio.c impr.c -D__ATOM__ -T ../../../lib/link.ld -o impr.elf


echo "Step-3: Run Executble..."
#./impr.out > dump2image.m
atomsim impr.elf --maxitr 10000000000 >dump2image.m

echo "Step-4: Display Images..."
octave --no-gui --eval "dump2image" --persist