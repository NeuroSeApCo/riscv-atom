function [add,carry]=fulladder(a,b,cin) %%%

    add=xor(xor(a,b),cin);
    carry=(a && b) || (xor(a,b) && cin);
    
return
end