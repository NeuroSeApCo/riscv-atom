function []=geterror(n,N,M) % 10^n = no of cases   N=block size
  num=power(10,n)   
  er=0;
  ed = zeros(1,num);
  red = zeros(1,num);
  maxi = 0;
  second = time();
  
  for i=1:num
    a=randi(power(2,N-1));
    b=randi(power(2,N-1));
    
    s=acep(a,b,N,M);
    sr=a+b;
    if(s!=sr)
        er = er+1;
        ed(i) = abs(sr-s);
        red(i) = abs(sr-s)/sr;
    end
  end

  er = (100*er)/num
  MED = mean(ed)
  NED = MED/max(ed)
  MRED = mean(red)
  second = time() - second

end
