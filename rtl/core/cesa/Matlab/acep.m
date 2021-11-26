function [sum]=acep(a,b,N,M)  %N=no of bits   %M=blocksize
   
   a=decimal2binary(N,a);
   b=decimal2binary(N,b);
   cin=0;
   n=N/M;   % no of block
   sum=0;
   
   for i=[0:1:n-1]
     
     strtindx=N-(i*M);
	   endindx=N-((i+1)*M)+1;
     
     [s,cin]=blockadder(a(endindx:strtindx),b(endindx:strtindx),cin,M);
     sum=[s,sum];
   end
   
sum=[cin,sum]; %set cout correctly
sum=sum(1:N+1);
sum=binary2decimal(N+1,sum);
   
end
