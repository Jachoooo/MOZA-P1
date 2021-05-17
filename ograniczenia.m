function [c, ceq]=ograniczenia(x, x0, freqency)
p=x.*x0;
[freq,y]=WSB_SP_sim_AC(p);
y=y';
[Avmax]=calc_peak(freq,y);
ceq=0;
[time0,y0, mat]= WSB_SP_sim(p);
index1=find_min_1(time0, freqency);
index2=find_min_2(time0, freqency);

uce1=(mat(3,index2)-mat(5,index2));
uce2=(mat(4,index1)-mat(6,index1));
ic1=(mat(15,index1))*1e3;
ic2=(mat(12,index2))*1e3;
ij=(mat(19,index2))*1e3;

c=[mag2db(Avmax/y(1))-1;... %podbicie charakterystyki
    -mag2db(y(1))+20;...   %wzmocnienie m.cz.
    -uce2+0.7;... %UCE Q2
    -uce1+0.7;... %UCE Q1
    -ic2+1e-3;... % IC Q2
    -ic1+1e-3;... % IC Q1
    -ij+1e-3 ];   %ID J1

end



