function []=myerror(n,N,M) % 10^n = no of cases   N=block size
  clc
  num=power(10,n)   
  second = time();
  
  errorsum=0;
  error=0;
  perc_error=0;
  perc_error_sum=0;
  correct_count=0
  correct_sum=0;
  
  for i=1:num
    a=randi(power(2,N-1))
    b=randi(power(2,N-1))
    
    s=acep(a,b,N,M)
    sr=a+b
    if(s!=sr)
        error=sr-s
        errorsum=errorsum+error;
        perc_error=(error/sr)*100
        perc_error_sum=perc_error_sum+perc_error;
    
    else
        correct_count=correct_count+1;
    end
    fprintf("-------------------------------------------------------------------\n");
  end
  
  avgerror=errorsum/num;
  avg_perc_error=perc_error_sum/num
  fprintf("out of %i cases %i %% cases gave correct answer\n",num,(correct_sum/num)*100);
  second = time() - second

end
