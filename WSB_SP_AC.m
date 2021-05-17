function [freq,y]=WS_SP(p,varnames,sp_fname,par_fname,raw_fname)
% y=BPF_SP(p,sp_fname,par_fname,bat_fname,raw_fname)
% Funkcja obliczaj¹ca przy pomocy NgSpice wartoœci
% |Av(f)| dla wartoœci f zapisanych w pliku analizy uk³adu
% Wartoœci czêstotliwoœci s¹ zwracane w wektorze freq, a 
% odpowiedzi - w wektorze y.
% varnames - cela, której sk³adowe s¹ nazwami parametrów z wektora p
% sp_fname - œcie¿ka do sparametryzowanego pliku opisuj¹cego uk³ad (*.asc)
% par_fname - œcie¿ka do pliku z definicjami zmiennych dla sp_fname
% bat_fname - plik wsadowy, wywo³uj¹cy LTspice'a dla sp_fname
% raw_fname - œcie¿ka do pliku, który ma zawieraæ wyniki symulacji .
% 3.XI.2015, L. Opalski
if nargin~=5, error('BPF_SP:1'); end
np=numel(varnames);
if(np~=numel(p)), error('varnames'); end
fid=fopen(par_fname,'w+');
if fid<0, error('open par_fname'); end
for n=1:np
    fprintf(fid,'.PARAM %s=%17.14g\n',varnames{n},p(n));
end
fclose(fid);
bat_fname1='scad3.exe';
[status,result]=system(sprintf('%s -b %s -r %s -Run',bat_fname1,sp_fname,raw_fname));
out=LTspice2Matlab(raw_fname); 
%out=LTS2Matlab(raw_fname);
%time=out.time_vect(:); 
freq=out.freq_vect;
y=abs(out.variable_mat(:));