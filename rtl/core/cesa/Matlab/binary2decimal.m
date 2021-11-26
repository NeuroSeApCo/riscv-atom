function [out]=binary2decimal(N,bin) %%working
out=0;
    for i=[1:1:N]
    
        if(bin(i)==1)
        
            out=out+2^(N-i);
        end
    end
return 
end