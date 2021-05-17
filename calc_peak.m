function [Avmax]=calc_peak(freq,y)
[ymax,iymax]=max(y);

if(iymax-1<=0) 
    Avmax=y(1);
else
    A=freq(iymax-1:iymax+1)-freq(iymax);
    A_new= (A - mean(A))/std(A);
    % interpolacja paraboliczna maksimum
    coef=polyfit(...
          A_new,...
          y(iymax-1:iymax+1)-ymax, 2);
    maks=-coef(2)/2/coef(1);
    Avmax=ymax+polyval(coef,maks);  
end