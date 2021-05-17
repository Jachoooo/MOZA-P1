function index = find_min_1(time0, freq)
%funkcja do wyliczenia czasu, w których Uce lub I osi¹ga min

col=find(time0>(0.00023/freq) & time0<(0.00027/freq));
if length(col)>1
    z=ceil(length(col)/2);
    index=col(z);
else
    index=col;
end

    
end
