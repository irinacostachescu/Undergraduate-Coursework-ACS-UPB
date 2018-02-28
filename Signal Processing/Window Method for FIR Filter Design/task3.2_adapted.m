%       File tema3_subpunctul_b_adap.M

%       Function: tema3_subpunctul_b_adap

%       Call: [k,delta_b_c,delta_s_c] = tema3_subpunctul_b_adap(wb,ws,delta_b,delta_s,M,wt,f)

%       Aceasta functie functioneaza in mod similar cu cea prezentata
%       anterior (tema3_subpunctul_b), cu exceptia faptului ca nu va mai
%       plota graficul amplitudinii raspunsului in frecventa, ci va returna
%       variabila k de tip intreg (k va fi 0 atunci cand conditiile
%       de abatere nu vor fi respectate si 1 altfel); va returna de asemenea
%       si valorile abaterilor calculate de care voi avea nevoie atunci cand
%       voi calcula suma acestora la tema 4. Functia foloseste in
%       continuare rutina tema3_subpunctul_a. Va fi folosita in rezolvarea
%       temei 4, pentru a determina cel mai bun filtru FTJ de tip FIR
%       In scopul utilizarii sale in tema 4, functia va primi ca argumente
%       de intrare wb, ws, delta_b, delta_s, M, wt si f.


%       Daca vor exista erori, programul se va incheia, afisand in linia de
%       comanda Matlab eroarea ce a provocat intreruperea functionarii.

%       Uses: WAR_ERR

%       Autor: Irina COSTACHESCU
%       Creat: Decembrie 18, 2017
%       Updatat: Ianuarie 5, 2018


function [k,delta_b_c,delta_s_c] = tema3_subpunctul_b_adap(wb,ws,delta_b,delta_s,M,wt,f)
k = 0;                  %Initializez k
h = fir1(M,wt,f);
[delta_b_c,delta_s_c] = tema3_subpunctul_a(wb,ws,h);
if (delta_b_c < delta_b && delta_s_c < delta_s)    %Compar abaterea cu cea admisa
    k = 1;
end
