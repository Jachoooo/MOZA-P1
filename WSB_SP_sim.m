function [time,y,mat]=WS_SP_sim(par)
sp_fname='WSB_DC.cir';
par_fname='parametry_inzynierskie.inc';
raw_fname='WSB_DC.raw';
varnames={'RC2';'RE2';'RF';'CF';'VDC'};
[time,y, mat]=WSB_SP(par,varnames,sp_fname,par_fname,raw_fname);

