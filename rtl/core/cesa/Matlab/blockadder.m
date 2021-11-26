function [sum,cout]=blockadder(a,b,cin,l)
  sum=zeros(1,l);
  cout=0;
  
  x=a(1);
  y=b(1);
  z=a(2);
  w=b(2);
  
  p=a(3);
  q=b(3);
  r=a(4);
  s=b(4);
  
  select=xor(x,y) & xor(z,w); %selection unit
  
  cout_post=(x&y) | (y&z&w) | (x&z&w);  %%  carry prediction on last and 2nd last bits 
  cout_pre=(p&q) | (q&r&s) | (p&r&s);  %carry prediction on 3rd last and 4th last bits
  
  cout=(~select&cout_post)|(select&cout_pre);   %mux
  
  
  for i=[l:-1:1]
    [sum(i),cin]=fulladder(a(i),b(i),cin);
  end
  %we got sum array of length 5

end
