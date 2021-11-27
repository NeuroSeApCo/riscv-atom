#include <stdio.h>

#include "lena.h"

typedef unsigned char uint8;
typedef unsigned int uint32;


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
    uint32 i, j;
    printf("I = [...\n");
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
    printf("figure;\n imshow(uint8(I));\n");
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
    /* KERNEL */ uint8 kernel[5][5])
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

                    acc = acc + ((imgpxl * kvalpxl)/273);
                }
            }
   
            // Substitution
            setPixel(outbuf, inbuf_hdim, i, j, acc);
        }    
    }
}

int main()
{
    // Print input image
    exportPixelMAtrix(ibuf, ibuf_vdim, ibuf_hdim);

    // Allocate space for output image
    uint8 obuf [ibuf_vdim * ibuf_hdim];
    unsigned int k=0;
    for(k=0; k<ibuf_hdim*ibuf_vdim; k++)
        obuf[k] = 0;

    // Perform Convolution
    conv2d(obuf, ibuf, ibuf_vdim, ibuf_hdim, kernel);

    // Print output image
    exportPixelMAtrix(obuf, ibuf_vdim, ibuf_hdim);

    return 0;
}