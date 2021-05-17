function [freq,y]=WS_SP(p,varnames,sp_fname,par_fname,raw_fname)
% y=BPF_SP(p,sp_fname,par_fname,bat_fname,raw_fname)
% Funkcja obliczaj�ca przy pomocy NgSpice warto�ci
% |Av(f)| dla warto�ci f zapisanych w pliku analizy uk�adu
% Warto�ci cz�stotliwo�ci s� zwracane w wektorze freq, a 
% odpowiedzi - w wektorze y.
% varnames - cela, kt�rej sk�adowe s� nazwami parametr�w z wektora p
% sp_fname - �cie�ka do sparametryzowanego pliku opisuj�cego uk�ad (*.asc)
% par_fname - �cie�ka do pliku z definicjami zmiennych dla sp_fname
% bat_fname - plik wsadowy, wywo�uj�cy LTspice'a dla sp_fname
% raw_fname - �cie�ka do pliku, kt�ry ma zawiera� wyniki symulacji .
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