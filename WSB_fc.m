function fc = WSB_fc(p, p0)
p=p.*p0;
[time,y]=WSB_SP_sim(p);
[f]=dynamika(y);

fc=-f;
end
