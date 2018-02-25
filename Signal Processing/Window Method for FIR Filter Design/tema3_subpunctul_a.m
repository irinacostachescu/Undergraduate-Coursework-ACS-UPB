%       File tema3_subpunctul_a.M

%       Function: tema3_subpunctul_a

%       Call: [delta_b_c, delta_s_c] = tema3_subpunctul_a(wb,ws,h)

%       Functia calculeaza abaterile maxime ale caracteristicii de
%       frecventa pentru un filtru h (dat ca argument de intrare) fata de
%       apmplitudinea caracteristicii de frecventa a unui filtru ideal. 
%       Aceste abateri vor fi returnate de functie si vor reprezenta : abaterea maxima in
%       banda de trecere delta_b_c (delta b calculat), respectiv abaterea
%       maxima in banda de stopare delta_s_c (delta s calculat).
%       Argumentele de intrare ale functiei vor fi reprezentate de h, wb si
%       ws. h a fost mentionat anterior din punct de vedere al utilizarii.
%       Ca tip de date, el va fi un vector de numere reale; wb si ws 
%       reprezinta benzile de trecere, respectiv stopare. Acestea vor fi de
%       tip real si subunitare, pentru a respecta conditia wb < wt < ws. In
%       cadrul calcului abaterii le voi inmulti insa cu pi pentru un calcul
%       corect in conformitate cu graficele. (wt subunitar pentru fir1)

%       Daca vor exista erori, programul se va incheia, afisand in linia de
%       comanda Matlab eroarea ce a provocat intreruperea functionarii.

%       Uses: WAR_ERR

%       Autor: Irina COSTACHESCU
%       Creat: Decembrie 18, 2017
%       Updatat: Ianuarie 5, 2018



function [delta_b_c,delta_s_c] = tema3_subpunctul_a(wb,ws,h)

grila_frecv = 0 : (wb*pi)/1000 : wb*pi; %Se genereaza suficient de multe 
                                      %puncte
H = freqz(h,1,grila_frecv);           %Se calculeaza caracteristica de frecventa
                                      %a filtrului pentru h dat
delta_b_c = max(abs(1-abs(H)));       %Se calculeaza abaterea maxima din banda de
                                      %trecere fata de amplitudinea ideala
                                      %a raspunsului in frecventa, adica
                                      %abaterea amplitudinii in jurul lui 1

grila_frecv = (ws*pi) : (pi-ws*pi)/1000 : pi;     %Se procedeaza in mod analog
                                                %pentru banda de stopare
H = freqz(h,1,grila_frecv);
delta_s_c = max(abs(H));            %abaterea amplitudinii in jurul lui 0

end