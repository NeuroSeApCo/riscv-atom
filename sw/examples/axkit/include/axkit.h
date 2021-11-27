/**
 * @file axkit.h
 * @author Siddharth Rajawat (siddhrth.rajawat@iiitg.ac.in)
 * @brief   This is a heaader only library which implements the runtime kernel for approximate computing 
 *          on RISC-V Systems. It contains the code to utilize the 'X' Extension of the RISC-V ISA at 
 *          end-application.
 *         
 *          Instructions:
 *              xadd    rd, rs1, rs2    :       Approximate Addition
 *              xmul    rd, rs1, rs2    :       Approximate Multiplication
 *              xmac    rd, rs1, rs2    :       Approximate Multiply and Accumulate (MAC)
 *              xconf   rd, rs1, rs2    :       Configure Approximate Hardware
 *  
 *          These instruction use the custom0 opciode space, i.e. 0b0001011
 * 
 * @see https://sourceware.org/binutils/docs-2.34/as/RISC_002dV_002dFormats.html
 *  
 * @version 0.1
 * @date 2021-11-26
 */

#ifndef __AXKIT_H__
#define __AXKIT_H__

/////////////////////////////////////////////////////////////////////////////////////////////////////
// General Definitions 

#ifndef __ASSEMBLY__
// Frequently used datatypes
typedef unsigned char byte;

typedef signed char int8;
typedef unsigned char uint8;

typedef signed int int32;
typedef unsigned int uint32;

typedef long signed int int64;
typedef long unsigned int uint64;
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////
// Library-Level Macros

// Configure Approximate Hardware
#ifdef __ASSEMBLY__
    #define xconf(device, conf)  \
        .insn r 0b0001011, 0b000, 0b0000000, device, zero, conf
#else
    #define xconf(device, conf)  \
        __asm__ volatile (".insn r 0b0001011, 0b000, 0b0000000, %0, zero, %1" : "=r"(device) : "r"(conf))
#endif

// Approximate Add
#ifdef __ASSEMBLY__
    #define xadd(ans, x, y)   \
        .insn r 0b0001011, 0b001, 0b0000000, ans, x, y
#else
    #define xadd(ans, x, y)   \
        __asm__ volatile (".insn r 0b0001011, 0b001, 0b0000000, %0, %1, %2" : "=r"(ans) : "r"(x), "r"(y))
#endif

// Aapproximate Multiply
#ifdef __ASSEMBLY__
    #define xmul(ans, x, y)   \
    .insn r 0b0001011, 0b010, 0b0000000, ans, x, y
#else
    #define xmul(ans, x, y)   \
        __asm__ volatile (".insn r 0b0001011, 0b010, 0b0000000, %0, %1, %2" : "=r"(ans) : "r"(x), "r"(y))
#endif


// Approximate MAC
#ifdef __ASSEMBLY__
    #define xmac(ans, x, y)   \
        .insn r 0b0001011, 0b011, 0b0000000, ans, x, y
#else
    #define xmac(ans, x, y)   \
        __asm__ volatile (".insn r 0b0001011, 0b011, 0b0000000, %0, %1, %2" : "=r"(ans) : "r"(x), "r"(y))
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////
// Wrapper Functions for Library-Level macros

#ifndef __ASSEMBLY__
// Configure Approximate Hardware
void xconf_f(uint32 device, uint32 conf)
{    
    xconf(device, conf);
}

// Approximate Add
uint32 xadd_f(uint32 x, uint32 y)
{    
    uint32 sum;
    xadd(sum, x, y);
    return sum;
}

// Aapproximate Multiply
uint32 xmul_f(uint32 x, uint32 y)
{    
    uint32 prod;
    xmul(prod, x, y);
    return prod;
}

// Approximate MAC
void xmac_f(uint32 *acc, uint32 x, uint32 y)
{    
    xmac(*acc, x, y);
}
#endif

#endif //__AXKIT_H__