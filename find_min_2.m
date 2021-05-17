function index = find_min_2(time0, freq)
%funkcja do wyliczenia czasu, w których Uce lub I osi¹ga min

col=find(time0>(0.00073/freq) & time0<(0.00077/freq));
if length(col)>1
    z=ceil(length(col)/2);
    index=col(z);
else
    index=col;
end

    
end
