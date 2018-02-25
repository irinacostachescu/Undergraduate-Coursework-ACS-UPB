%       File tema4.M

%       Function: tema4

%       Call: [ordin_min, wt_min, abatere_min] = tema4(wb,ws,delta_b,delta_s)

%       Functia calculeaza cel mai bun FTJ de tip FIR. Primeste ca
%       argumente datele de proiectare ale unui PPFTI si anume, wb - banda
%       de trecere, ws - banda de stopare, delta_b - abaterea maxim admisa
%       in banda de trecere, delta_c - abaterea maxim admisa in banda de
%       stopare. Furnizeaza ca rezultat vectorul ce contine ordinul minim
%       pentru fiecare fereastra (9 ferestre, lungimea lui M e 9), vectorul
%       wt_min ce contine, pentru fiecare fereastra, frecventa de taiere
%       pentru care s-a atins ordinul minim si vectorul abatere_min ce
%       contine, de asemenea, pentru fiecare fereastra suma abaterilor (cea
%       din banda de trecere + cea din banda de stopare) pentru fiecare
%       fereastra de ordin minim. Valorile din cei trei vectori corespund 
%       ferestrelor in ordinea prezentata in laborator. primul element - 
%       fereastra rectangulara, al doilea - fereastra triunghiulara, etc.
%       Functia variaza pe M de la 70 la 1. Pentru fiecare M variaza
%       frecventa de taiere wt si in cazul ferestrelor cu parametru,
%       parametrul respectiv (r - Cebyshev, beta - Kaiser, etc) pana cand
%       gaseste o combinatie pentru care functia tema3_subpunctul_b_adap
%       returneaza k = 1 (ceea ce inseamna ca filtrul proiectat respecta
%       abaterile impuse). Programul continua iteratiile pana cand va gasi
%       un M care nu respecta conditia. Astfel ca ultimul M (cel minim) care
%       indeplineste conditia admisa e salvat in vectorul ordin_min in
%       timp ce frecventa de taiere pentru care se atinge acest ordin minim
%       in vectorul wt_min. Se calculeaza apoi si se pune in vectorul
%       abatere_min suma delta_b_c + delta_s_c, astfel incat, daca in
%       vectorul ordin_min exista doua valori minime egale, in urma afisarii
%       vectorului abatere_min sa putem concluziona care filtru este mai
%       performant. Functia va afisa de asemenea un mesaj in care se va
%       specifica numele ferestrei "castigatoare".


%       Daca vor exista erori, programul se va incheia, afisand in linia de
%       comanda Matlab eroarea ce a provocat intreruperea functionarii.


%       Uses: WAR_ERR

%       Autor: Irina COSTACHESCU
%       Creat: Decembrie 18, 2017
%       Updatat: Ianuarie 5, 2018 


function [ordin_min,wt_min, abatere_min] = tema4(wb,ws,delta_b,delta_s)

abatere_min = zeros(1,9);
wt_min = zeros(1,9);
ordin_min = zeros(1,9);


% RECTANGULAR
for M = 50:-1:1
    f = boxcar(M+1);
    for wt = wb:0.01:ws
        [k,delta_b_c,delta_s_c] = tema3_subpunctul_b_adap(wb,ws,delta_b,delta_s,M,wt,f);
        if (k == 1)
            ordin_min(1) = M;  %salvez ordinul minim
            abatere_min(1) = delta_b_c + delta_s_c; %salvez abaterea minima
            wt_min(1) = wt;    %salvez frecventa de taiere minima
        end
    end
end

%TRIANGULAR
for M = 50:-1:1
    f = triang(M+1);
    for wt = wb:0.01:ws
        [k,delta_b_c,delta_s_c] = tema3_subpunctul_b_adap(wb,ws,delta_b,delta_s,M,wt,f);
        if (k == 1)
            ordin_min(2) = M;  
            abatere_min(2) = delta_b_c + delta_s_c;
            wt_min(2) = wt;    
        end
    end
end 


% %BLACKMAN
for M = 50:-1:1
    f = blackman(M+1);
    for wt = wb:0.01:ws
        [k,delta_b_c,delta_s_c] = tema3_subpunctul_b_adap(wb,ws,delta_b,delta_s,M,wt,f);
        if (k == 1)
            ordin_min(3) = M; 
            abatere_min(3) = delta_b_c + delta_s_c;
            wt_min(3) = wt;    
        end
    end
end 



%CHEBYSHEV
for M = 50:-1:1
    for r = 80:100
        f = chebwin(M+1,r);
        for  wt = wb:0.01:ws
            [k,delta_b_c,delta_s_c] = tema3_subpunctul_b_adap(wb,ws,delta_b,delta_s,M,wt,f);
            if (k == 1)
                ordin_min(4) = M;                   %se salveaza M minim
                abatere_min(4) = delta_b_c + delta_s_c;
                wt_min(4) = wt;
                r1 = r;         %salvez parametrul pentru care s-a obtinut minimul
            end
        end
    end
end
 


%HAMMING
for M = 50:-1:1
    f = hamming(M+1);
    for wt = wb:0.01:ws
        [k,delta_b_c,delta_s_c] = tema3_subpunctul_b_adap(wb,ws,delta_b,delta_s,M,wt,f);
        if (k == 1)
            ordin_min(5) = M; 
             abatere_min(5) = delta_b_c + delta_s_c;
            wt_min(5) = wt;   
        end
    end
end


% %HANNING
for M = 50:-1:1
    f = hanning(M+1);
    for wt = wb:0.01:ws
        [k,delta_b_c,delta_s_c] = tema3_subpunctul_b_adap(wb,ws,delta_b,delta_s,M,wt,f);
        if (k == 1)
            ordin_min(6) = M;   
            abatere_min(6) = delta_b_c + delta_s_c;
            wt_min(6) = wt;    
        end
    end
end

%KAISER
for M = 50:-1:1
    for beta = 0:0.1:10
        f = kaiser(M+1,beta);
        for  wt = wb:0.01:ws
            [k,delta_b_c,delta_s_c] = tema3_subpunctul_b_adap(wb,ws,delta_b,delta_s,M,wt,f);
            if (k == 1)
                ordin_min(7) = M;                   %se salveaza M minim
                abatere_min(7) = delta_b_c + delta_s_c;
                wt_min(7) = wt;
                beta1 = beta;
            end
        end
    end
end

%LANCZOS
for M = 50:-1:1
    for L = 0:0.1:3;
        f = lanczos(M+1,L);
        for  wt = wb:0.01:ws
            [k,delta_b_c,delta_s_c] = tema3_subpunctul_b_adap(wb,ws,delta_b,delta_s,M,wt,f);
            if (k == 1)
                ordin_min(8) = M;                   %se salveaza M minim
                abatere_min(8) = delta_b_c + delta_s_c;
                wt_min(8) = wt;
                L1 = L;
            end
        end
    end
end

%TUKEY
for M = 50:-1:1
    for alfa = 0:0.1:1;
        f = tukeywin(M+1,alfa);
        for  wt = wb:0.01:ws
            [k,delta_b_c,delta_s_c] = tema3_subpunctul_b_adap(wb,ws,delta_b,delta_s,M,wt,f);
            if (k == 1)
                ordin_min(9) = M;                   %se salveaza M minim
                abatere_min(9) = delta_b_c + delta_s_c;
                wt_min(9) = wt;
                alfa1 = alfa;
            end
        end
    end
end

l = 1;
cel_mai_mic_ordin = min(ordin_min);
for i = 1: length(ordin_min)
    if (ordin_min(i) == cel_mai_mic_ordin)
        window(l) = i;
        l = l+1;
    end
end

l = 1;
for i = 1 : length(window)
    cea_mai_mica_abatere (l) = abatere_min(window(i));
    l = l+1;
end

abatmin = min(cea_mai_mica_abatere);

for i = 1:length(abatere_min)
    if (abatere_min(i) == abatmin)
        winner = i;
    end
end

if(winner == 1)
    disp(['Cel mai bun filtru este cel proiectat cu o fereastra Rectangulara de ordin ', num2str(ordin_min(1)), ' cu o frecventa de taiere wt = ', num2str(wt_min(1)), ' cu o abatere de ', num2str(abatere_min(1))]);
end
if(winner == 2)
    disp(['Cel mai bun filtru este cel proiectat cu o fereastra Triunghiulara de ordin ', num2str(ordin_min(2)), ' cu o frecventa de taiere wt = ', num2str(wt_min(2)), ' cu o abatere de ', num2str(abatere_min(2))]);
end
if(winner == 3)
    disp(['Cel mai bun filtru este cel proiectat cu o fereastra Blackman de ordin ', num2str(ordin_min(3)), ' cu o frecventa de taiere wt = ', num2str(wt_min(3)), ' cu o abatere de ', num2str(abatere_min(3))]);
end
if(winner == 4)
    disp(['Cel mai bun filtru este cel proiectat cu o fereastra Cebyshev de ordin ', num2str(ordin_min(4)), ' cu o frecventa de taiere wt = ', num2str(wt_min(4)), ' cu o abatere de ', num2str(abatere_min(4)), ' si pentru parametrul r de valoare ', num2str(r1)]);
end 
if(winner == 5)
    disp(['Cel mai bun filtru este cel proiectat cu o fereastra Hamming de ordin ', num2str(ordin_min(5)), ' cu o frecventa de taiere wt = ', num2str(wt_min(5)), ' cu o abatere de ', num2str(abatere_min(5))]);   
end
if(winner == 6)
    disp(['Cel mai bun filtru este cel proiectat cu o fereastra Hanning de ordin ', num2str(ordin_min(6)), ' cu o frecventa de taiere wt = ', num2str(wt_min(6)), ' cu o abatere de ', num2str(abatere_min(6))]);
end
if(winner == 7)
    disp(['Cel mai bun filtru este cel proiectat cu o fereastra Kaiser de ordin ', num2str(ordin_min(7)), ' cu o frecventa de taiere wt = ', num2str(wt_min(7)), ' cu o abatere de ', num2str(abatere_min(7)), ' si pentru parametrul beta de valoare ', num2str(beta1)]);
end
if(winner == 8)
    disp(['Cel mai bun filtru este cel proiectat cu o fereastra Lanczos de ordin ', num2str(ordin_min(8)), ' cu o frecventa de taiere wt = ', num2str(wt_min(8)), ' cu o abatere de ', num2str(abatere_min(8)), ' si pentru parametrul L de valoare ', num2str(L1)]);
end
if(winner == 9)
    disp(['Cel mai bun filtru este cel proiectat cu o fereastra Tukey de ordin ', num2str(ordin_min(9)), ' cu o frecventa de taiere wt = ', num2str(wt_min(9)), ' cu o abatere de ', num2str(abatere_min(9)), ' si pentru parametrul alfa de valoare ', num2str(alfa)]);
end
end