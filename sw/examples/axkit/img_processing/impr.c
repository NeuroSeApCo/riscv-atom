#ifndef __ATOM__
#include <stdio.h>

#else
#include "../../../lib/atombones.h"
#include "../../../lib/stdio.h"
#endif

#include "../include/axkit.h"

#include "input_image.h"

typedef unsigned char uint8;
typedef unsigned int uint32;

static unsigned int xcount = 0;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Accessor Functions for 1D arrays
uint8 getPixel(uint8 * buf, uint32 hdim, uint32 v, uint32 h)
{
    return buf[(v * hdim) + h];
}

void setPixel(uint8 * buf, uint32 hdim, uint32 v, uint32 h, uint8 value)
{
    buf[(v * hdim) + h] = value;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Export pixel matrix


void exportPixelMAtrix(uint8 * buf, uint32 hdim, uint32 vdim)
{
    #ifdef __ATOM__
    uint32 i, j;

    print_str("[...\n");
    for(i=0; i<vdim; i++)
    {
        for(j=0; j<hdim; j++)
        {
            print_int(getPixel(buf, hdim, i, j), 10); print_chr(' ');
        }

        if(i == vdim-1)
            print_str("];\n");
        else
            print_str(";\n");
    }

    #else
    uint32 i, j;
    printf("[...\n");
    for(i=0; i<vdim; i++)
    {
        for(j=0; j<hdim; j++)
        {
            printf("%d ", getPixel(buf, hdim, i, j));
        }

        if(i == vdim-1)
            printf("];\n");
        else
            printf(";\n");
    }
    #endif
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Kernel & Convolution
uint8 kernel [5][5] = 
{
    {1, 4,  7,  4,  1},
    {4, 16, 26, 16, 4},
    {7, 26, 41, 26, 7},
    {4, 16, 26, 16, 4},
    {1, 4,  7,  4,  1}
};


void conv2d(/* OUTBUF */uint8 * outbuf, /* INBUF */ uint8 * inbuf, uint32 inbuf_vdim, uint32 inbuf_hdim,
    /* KERNEL */ uint8 kernel[5][5], int approximate)
{
    uint32 i, j;
    
    for(i=2; i< inbuf_vdim-2; i++)
    {
        for(j=2; j< inbuf_hdim-2; j++)
        {            
            // MAC
            int x, y;
            uint32 acc = 0;

            for (y=-2; y<=2; y++)
            {
                for (x=-2; x<=2; x++)
                {
                    uint32 imgpxl = getPixel(inbuf, inbuf_hdim, i+y, j+x);
                    uint32 kvalpxl = getPixel((uint8 *)kernel, 5, 2+y, 2+x);
                    
                    if(approximate == 1)
                    {
                        acc = xadd_f(acc, (imgpxl * kvalpxl));
			xcount++;
                    }
                    else
                    {
                        acc = acc + (imgpxl * kvalpxl);
                    }
                }
            }
   
            // Substitution
            setPixel(outbuf, inbuf_hdim, i, j, acc/273);
        }
    }
}

int main()
{
    // Export input image

    print_str("pkg load image\n");

    print_str("I = ");
    exportPixelMAtrix(ibuf, ibuf_vdim, ibuf_hdim);

    // Allocate space for output image - accurate
    uint8 obufa [ibuf_vdim * ibuf_hdim];

    // Allocate space for output image - approximate
    uint8 obufx [ibuf_vdim * ibuf_hdim];

    unsigned int k=0;
    for(k=0; k<ibuf_hdim*ibuf_vdim; k++)
    {    
        obufa[k] = 0;
        obufx[k] = 0;
    }
    
    // Perform Convolution - accurate
    conv2d(obufa, ibuf, ibuf_vdim, ibuf_hdim, kernel, 0);

    // Perform Convolution - approximate
    conv2d(obufx, ibuf, ibuf_vdim, ibuf_hdim, kernel, 1);

    // Export output image - accurate
    print_str("Ia = ");
    exportPixelMAtrix(obufa, ibuf_vdim, ibuf_hdim);
    
    // Export output image - approximate
    print_str("Ix = ");
    exportPixelMAtrix(obufx, ibuf_vdim, ibuf_hdim);

    print_str("I = uint8(I);\n");
    print_str("Ia = uint8(Ia);\n");
    print_str("Ix = uint8(Ix);\n");

    print_str("subplot(1, 3, 1); imshow(I); title(\"Original\");\n");
    print_str("subplot(1, 3, 2); imshow(Ia); title(\"Accurate\");\n");
    print_str("subplot(1, 3, 3); imshow(Ix); title(\"Approximate\");\n");
    
    print_str("psnr(Ix, Ia)\n");
    print_str("# no of ops: "); print_int(xcount, 10);

    return 0;
}
