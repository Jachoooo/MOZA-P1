function [time,y]=WS_SP_sim(par)
sp_fname='WSB_AC.cir';
par_fname='parametry_inzynierskie.inc';
raw_fname='WSB_AC.raw';
varnames={'RC2';'RE2';'RF';'CF';'VDC'};
[time,y]=WSB_SP_AC(par,varnames,sp_fname,par_fname,raw_fname);
