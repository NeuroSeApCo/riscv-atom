#include "axkit_ops.S"
.global main

.text
main:
    # ===== Testcase-1 =====
    li t1, 2234342
    li t2, 43222
    add t3, t1, t2      
    xadd(t4, t2, t1) 
    # Accurate Sum (t3)      = 2277564 (0x22c0bc)
    # Approximate Sum (t4)   = 2273468 (0x22b0bc)
    # Relative Error Percent = 0.17 %

    # ===== Testcase-2 =====
    li t1, 212422
    li t2, 4312212
    add t3, t1, t2 
    xadd(t4, t2, t1) 
    # Accurate Sum (t3)      = 4524634 (0x450a5a)
    # Approximate Sum (t4)   = 4459098 (0x440a5a)
    # Relative Error Percent = 1.44 %

    jr ra

.data
.word(123)