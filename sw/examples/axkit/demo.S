#include "custom_ops.S"

.section .boot, "ax", @progbits
.global _start
.global _exit

.text
_start:
    
    li x1, 0x24342
    li x2, 0x14322

    xadd(x3, x1, x2)

    li x1, 0x123
    li x2, 0x4533

    xadd(x3, x1, x2)

_exit:
    j _exit
