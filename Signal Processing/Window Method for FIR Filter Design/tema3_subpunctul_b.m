%       File tema3_subpunctul_b.M

%       Function: tema3_subpunctul_b

%       Call: tema3_subpunctul_b(wb,ws,delta_b,delta_s)

%       Pentru argumentele de intrare date in enuntul problemei, wb = banda
%       de trecere, ws = banda de stopare, delta_b = toleranta maxima a
%       abaterii in banda de trecere, delta_c = toleranta maxima a abaterii
%       in banda de stopare, functia va returna graficul amplitudinii
%       raspunsului in frecventa al unui filtru h de ordin M ales, cu
%       ajutorul unei ferestre alese. De asemenea, aleg si valoarea pentru
%       wt. Functia va folosi functia de la punctul anterior ce returneaza
%       pentru filtrul proiectat valorile delta_b_c si delta_b_s si le
%       compara cu cele date (maxime admise). Daca se depasesc valorile
%       limita, se va afisa un mesaj conform caruia filtrul trebuie
%       reproiectat. Aleg wb si ws fara a le inmulti cu pi, ca si pana acum
%       pentru a respecta conditia wb < wt < ws. Le inmultesc ulterior cu
%       pi pentru o reprezentare grafica corecta. Se pot modifica ordinul
%       filtrului, valoarea frecventei de taiere precum si fereastra
%       folosita din liniile 36, 37, respectiv 38. 

%       Daca vor exista erori, programul se va incheia, afisand in linia de
%       comanda Matlab eroarea ce a provocat intreruperea functionarii.

%       Uses: WAR_ERR

%       Autor: Irina COSTACHESCU
%       Creat: Decembrie 18, 2017
%       Updatat: Ianuarie 5, 2018



function  tema3_subpunctul_b (wb,ws,delta_b,delta_s)
wt1 = 0.4;
M = 15;
f = kaiser(M+1,2);
h = fir1(M,wt1,f);

[delta_b_c,delta_s_c] = tema3_subpunctul_a(wb,ws,h); %Calculez abaterile maxime

if (delta_b_c <= delta_b) %Compar abaterea cu cea admisa
    Message = 'Filtrul respecta abaterea din banda de trecere';
else 
    Message = 'Filtrul nu respecta abaterea din banda de trecere, trebuie reproiectat';
end
disp(Message);



if (delta_s_c <= delta_s) %Compar abaterea cu cea admisa
    Message = 'Filtrul respecta abaterea din banda de stopare';
else
    Message = 'Filtrul nu respecta abaterea din banda de stopare, trebuie reproiectat';
end
disp(Message);


[H,w] = freqz(h); %Raspunsul in frecventa
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H)); %Trasez amplitudinea


%{
Trasez valorile limita pentru a observa in forma grafica daca filtrul
proiectat respecta tolerantele impuse
%}
line([wb*pi wb*pi],[0 1-delta_b], 'Color', 'red', 'LineStyle', '--');
line([ws*pi ws*pi],[0 delta_s], 'Color', 'red', 'LineStyle', '--');
line([0 wb*pi],[1+delta_b 1+delta_b], 'Color', 'red', 'LineWidth', 2);
line([0 wb*pi],[1-delta_b 1-delta_b], 'Color', 'red', 'LineWidth', 2);
line([0 pi],[delta_s delta_s], 'Color', 'red', 'LineStyle', '--');
line([ws*pi pi],[delta_s delta_s], 'Color', 'red', 'LineWidth', 2);
set(gca,'XTick',[wb*pi ws*pi pi],'XTickLabel',{'wb','ws','pi'});
yt = {'0' ; 'delta_s' ; '1-delta_b' ; '1' ; '1+delta_b'};
set(gca,'ytick',[0,delta_s,1-delta_b,1,1+delta_b]);
set(gca,'yticklabel',yt);
xlabel('w');
ylabel('Amplitudinea raspunsului in frecventa');
title('Caracteristica de frecventa (amplitudine) cu tolerante impuse');
end
