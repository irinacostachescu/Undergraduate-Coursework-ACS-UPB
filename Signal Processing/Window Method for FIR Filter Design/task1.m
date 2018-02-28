%       File tema1.M

%       Call: click Run

%       Ploteaza raspunsurile la impuls ale celor 9 ferestre prezentate
%       in enuntul temei. Foloseste functia stem(f) pentru reprezentare
%       si functiile implicite Matlab pentru creare de vectori tip 
%       fereastra. Se vo trasa 9 grafice, fiecare continand reprezentarea 
%       unei ferestre.
%       In continuare, in figura nr 10, se vor trasa (cu subplot), ampli-
%       tudinile raspunsurilor in frecventa ale celor 9 ferestre;
%       Mentionez ca variabila f va fi un vector de numere reale, in timp
%       ce parametri fiecarei ferestre(acolo unde exista : Cebyshev,
%       Kaiser, Tukey, Lanczos) vor fi de tip numere reale pozitive. M este 
%       un numar natural. Functia va afisa de asemenea si raspunsurile date
%       de wvtool (grafice + parametri de compartie a celor noua ferestre)

%       Se poate modifica valoarea parametrului M de pe linia 31 cu scopul
%       obtinerii unor filtre de alt ordin.

%       Daca vor exista erori, programul se va incheia, afisand in linia de
%       comanda Matlab eroarea ce a provocat intreruperea functionarii.

%       Uses: WAR_ERR

%       Autor: Irina COSTACHESCU
%       Creat: Decembrie 18, 2017
%       Updatat: Ianuarie 5, 2018
% 

M = 16;

%{
SUBPUNCTUL a:
Raspunsurile la impuls ale celor 9 ferestre; Pentru ferestrele
cu parametru, am variat valorile conform enuntului.
%}
figure(1)           
f = boxcar(M);
stem(f);
title('Rectangular');

figure(2)
f = triang(M);
stem(f);
title('Triangular (Bartlett)');

figure(3)
f = blackman(M);
stem(f);
title('Blackman');

figure(4)
r = 80;
f = chebwin(M,r);
stem(f);
hold on
r = 90;
f = chebwin(M,r);
stem(f);
hold on
r = 95;
f = chebwin(M,r)
stem(f);
hold on
r = 100;
f = chebwin(M,r);
stem(f);
title('Chebyshev');
legend('r = 80dB','r = 90dB','r = 95dB','r = 100dB');

figure(5)
f = hamming(M);
stem(f);
title('Hamming');

figure(6)
f = hanning(M);
stem(f);
title('Hanning');

figure(7)
beta = 1;
f = kaiser(M,beta);
stem(f);
hold on
beta = 3;
f = kaiser(M,beta);
stem(f);
hold on
beta = 5;
f = kaiser(M,beta);
stem(f);
hold on
beta = 9;
f = kaiser(M,beta);
stem(f);
title('Kaiser');
legend('beta = 1dB','beta = 3dB','beta = 5dB','beta = 9dB');

figure(8)
L = 0.5;
f = lanczos(M,L);
stem(f);
hold on;
L = 1;
f = lanczos(M,L);
stem(f);
hold on;
L = 2;
f = lanczos(M,L);
stem(f);
hold on;
L = 3;
f = lanczos(M,L);
stem(f);
legend('L = 0.5','L = 1','L = 2','L = 3');
title('Lanczos');

figure(9)
alfa = 0.25;
f = tukeywin(M,alfa);
stem(f);
hold on
alfa = 0.47;
f = tukeywin(M,alfa);
stem(f);
hold on
alfa = 0.78;
f = tukeywin(M,alfa);
stem(f);
hold on
alfa = 1;
f = tukeywin(M,alfa);
stem(f);
title('Tukey');
legend('alfa = 25%','alfa = 47%','alfa = 78%','alfa = 100% ');

%{
SUBPUNCTUL b:
Amplitudinile raspunsurilor in frecventa pentru cele noua ferestre;
Pentru ferestrele cu parametru, am variat valorile conform enuntului
%}


figure(10)
subplot(331)
f = boxcar(M);
f = f/sum(f);       %Normare
[F,w] = freqz(f);   %Calcul raspuns in frecventa
w = w/pi;           %Am normalizat frecventa pentru a obtine graficele la 
                    %la fel ca cele din pdf-ul cu enuntul temei;
plot(w,20*log10(abs(F))); %am plotat amplitudinea in dB
title('Rectangular');
ylabel('[dB]');

subplot(332);
f = triang(M);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
ylabel('[dB]');
title('Triangular (Bartlett)');

subplot(333)
f = blackman(M);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
ylabel('[dB]');
title('Blackman');

subplot(334)
r = 82;
f = chebwin(M,r);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
hold on
r = 90;
f = chebwin(M,r);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
hold on
r = 95;
f = chebwin(M,r);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
hold on
r = 100;
f = chebwin(M,r);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
ylabel('[dB]');
legend('r = 82dB','r = 90dB','r = 95dB','r = 100dB');
title('Chebyshev');

subplot(335)
f = hamming(M);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
title('Hamming');

subplot(336)
f = hanning(M);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
ylabel('[dB]');
title('Hanning');

subplot(337)
beta = 1;
f = kaiser(M,beta);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
hold on
beta = 3;
f = kaiser(M,beta);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
hold on
beta = 5;
f = kaiser(M,beta);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
hold on
beta = 9;
f = kaiser(M,beta);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
ylabel('[dB]');
legend('beta = 1dB','beta = 3dB','beta = 5dB','beta = 9dB');
title('Kaiser');

subplot(338)
L = 0.5;
f = lanczos(M,L);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
hold on
L = 1;
f = lanczos(M,L);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
hold on
L = 2;
f = lanczos(M,L);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
hold on
L = 3;
f = lanczos(M,L);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
ylabel('[dB]');
legend('L = 0.5','L = 1','L = 2','L = 3');
title('Lanczos');

subplot(339)
alfa = 0.25;
f = tukeywin(M,alfa);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
hold on
alfa = 0.47;
f = tukeywin(M,alfa);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
hold on
alfa = 0.78;
f = tukeywin(M,alfa);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
hold on
alfa = 1;
f = tukeywin(M,alfa);
f = f/sum(f);
[F,w] = freqz(f);
w = w/pi;
plot(w,20*log10(abs(F)));
legend('alfa = 25%','alfa = 47%','alfa = 78%','alfa = 100% ');
ylabel('[dB]');
title('Tukey');

%{
Comparatia intre tipurile de ferestre utilizate, folosind functia wvtool
care returneaza parametri necesati evaluarii performantelor ferestrelor.
Latimea lobului principal si atenuarea lobilor secundari
%}
f = boxcar(M+1);
wvtool(f);
f = triang(M+1);
wvtool(f)
f = blackman(M+1);
wvtool(f)
f = chebwin(M+1,80);
wvtool(f)
f = chebwin(M+1,90);
wvtool(f)
f = chebwin(M+1,95);
wvtool(f)
f = chebwin(M+1,100);
wvtool(f)
f = hamming(M+1);
wvtool(f)
f = hanning(M+1);
wvtool(f)
f = kaiser(M+1,1);
wvtool(f)
f = kaiser(M+1,3);
wvtool(f)
f = kaiser(M+1,5);
wvtool(f)
f = kaiser(M+1,7);
wvtool(f)
f = lanczos(M+1,0.5);
wvtool(f)
f = lanczos(M+1,1);
wvtool(f)
f = lanczos(M+1,2);
wvtool(f)
f = lanczos(M+1,3);
wvtool(f)
f = tukeywin(M+1,0.25);
wvtool(f)
f = tukeywin(M+1,0.47);
wvtool(f)
f = tukeywin(M+1,0.78);
wvtool(f)
f = tukeywin(M+1,1);
wvtool(f)











