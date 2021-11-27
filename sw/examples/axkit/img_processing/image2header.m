pkg load image

% Take fresh image
I = imread("lena128x128.png")
I = imresize(I, 0.5)
I = padarray(I,[2 2]);
sz = size(I)

fid = fopen ("lena.h", "w");

fprintf(fid, "unsigned int ibuf_vdim = %d;\n", sz(1));
fprintf(fid, "unsigned int ibuf_hdim = %d;\n\n", sz(2));

fprintf(fid, "unsigned char ibuf [%d] = {\n", sz(1) * sz(2));
for row=1:sz(1)
    for col=1:sz(1)
        fprintf(fid, "\t%d", I(row, col))    
        
        if row == sz(1) && col == sz(2)
            fprintf(fid, "\n", I(row, col))
        else
            fprintf(fid, ",\n", I(row, col))
        endif
        
    endfor
endfor

fprintf(fid, "};\n");

fclose(fid)