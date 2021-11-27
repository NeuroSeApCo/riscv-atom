echo "Step-1: Generating input imge header..."
octave --no-gui --eval "image2header"

echo "Step-2: Compiling code with header..."
gcc -Wall impr.c -o impr.out

echo "Step-3: Run Executble..."
./impr.out > dump2image.m

echo "Step-4: Display Images..."
octave --no-gui --eval "dump2image" --persist