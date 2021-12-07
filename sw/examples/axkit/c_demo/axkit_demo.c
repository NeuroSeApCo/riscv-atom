#include "../../../lib/atombones.h"
#include "../../../lib/stdio.h"

#include "../include/axkit.h"

int main()
{   
    unsigned int x = 2234342;
    unsigned int y = 43222;

    unsigned int ans = 0;

    xadd(ans, x, y);

    print_int(x, 10); print_str(" + "); print_int(y, 10); print_str(" = "); print_int(x+y, 10); print_str(" ( "); print_int(ans, 10); print_str(" )\n");
    
    // Accurate Sum (t3)      = 2277564 (0x22c0bc)
    // Approximate Sum (t4)   = 2273468 (0x22b0bc)
    // Relative Error Percent = 0.17 %
}