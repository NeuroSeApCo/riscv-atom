function bin=decimal2binary(N,dec) %%working
	i=1;
	while(i<=N)
		bin(N+1-i)=mod(dec,2);
		dec=floor(dec/2);
		i=i+1;
	end
return
end