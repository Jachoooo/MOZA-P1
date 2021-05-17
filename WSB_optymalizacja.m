%Glowny plik testowy
diary
clear all; close all; clc;
chwile=1; %czêstotliwoœæ sygna³u
p0=[5000.00; 100.00; 800.00; 1.00e-12; -1.2]; %punkt startowy
[time0,y0, mat]= WSB_SP_sim(p0);
[freq0,y00]= WSB_SP_sim_AC(p0);
y00=y00';
time00=time0*1000;
y00_db=mag2db(y00);

% afiniczne skalowanie zmiennych
x0=p0./p0;
f=@(x)WSB_fc(x,p0);
og=@(x)ograniczenia(x,p0,chwile);
%{
[c,ceq]=ograniczenia(x0,p0,freq);
C={ "Podbicie", "Wzmocnienie", "U_CE Q2", "U_CE Q1", "IC Q2", "IC Q2", "ID J1";
    c(1)+1, -c(2)+20, -c(3)+0.5, -c(4)+0.5, (-c(5)+1e-6)*1000, (-c(6)+1e-6)*1000, (-c(7)+1e-6)*1000};
fc=WSB_fc(x0, p0);
%}
%%
lb=[0.3,0.3,0.45,0.5,0.8];
ub=[2,2,1.2,2,1.2];
        
opts=optimset('Display','iter','MaxFunEvals',1000,'FinDiffRelStep',1e-5, 'Algorithm', 'interior-point', 'PlotFcn',{@optimplotx,@optimplotfval});
[xopt,fval,exit, output]=fmincon(f,x0,[],[],[],[],lb,ub,og,opts)
%%
popt=xopt.*p0;

[time_opt,y_dc_opt, mat_opt]= WSB_SP_sim(popt);
[Vmax_opt]=dynamika(y_dc_opt);
[freq_opt,y_ac_opt]=WSB_SP_sim_AC(popt);
y_ac_opt=mag2db(y_ac_opt');
time_opt=time_opt*1000;

%%
figure(2)
plot(time00,y0)
hold on
plot(time_opt, y_dc_opt)
xlabel("Czas [ms]")
ylabel("Napiêcie Vout [V]")
legend("Przed", "Po")
title("Przebieg napiêcia Vout w funkcji czasu")

ku0=[];
i=0;
for i=1:length(freq_opt)
    ku0(i)=20;
end

figure(3)
semilogx(freq0,y00_db)
hold on
semilogx(freq_opt, y_ac_opt)
semilogx(freq_opt, ku0, "g")
xlabel("Czêstotliwoœæ [Hz]")
ylabel("Wzmocnienie [dB]")
legend("Przed", "Po", "Wzmocnienie=10V/V")
title("Charakterystyka czêstotliwoœciowa")
%%
%OGRANICZENIA
Uce1=mat_opt(3,:)-mat_opt(5,:);
Uce2=mat_opt(4,:)-mat_opt(6,:);
Ic1=mat_opt(15,:).*1000;
Ic2=mat_opt(12,:).*1000;
Ij=mat_opt(19,:).*1000;

nasycenie=[];
i=0;
for i=1:length(time_opt)
    nasycenie(i)=0.7;
end
zatkanie=[];
i=0;
for i=1:length(time_opt)
    zatkanie(i)=1e-3;
end
    
figure(4)
plot(time_opt, Uce1)
hold on
plot(time_opt, Uce2)
plot(time_opt, nasycenie, "g")
hold off
xlabel("Czas [ms]")
ylabel("U [V]")
legend("UCE Q1", "UCE Q2", "0,7V")
title("Przebiegi napiêæ kolektor-emiter")

figure(5)
plot(time_opt, Ic1)
hold on
plot(time_opt, Ic2)
plot(time_opt, Ij)
plot(time_opt, zatkanie, "g")

hold off
xlabel("Czas [ms]")
ylabel("I [mA]")
legend("IC Q1", "IC Q2", "ID J1", "1uA")
title("Przebiegi pr¹dów tranzystorów")

%%
x0=popt./popt;
[c,ceq]=ograniczenia(x0,popt,chwile);
C={ "Podbicie", "Wzmocnienie", "U_CE Q2", "U_CE Q1", "IC Q2", "IC Q2", "ID J1";
    c(1)+1, -c(2)+20, -c(3)+0.7, -c(4)+0.7, (-c(5)+1e-3), (-c(6)+1e-3), (-c(7)+1e-3)};