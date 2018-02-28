%       File tema2.M

%       Function: tema2

%       Call:   tema2(wt,M)

%       Se aleg parametri de intrare wt1 si M. wt1 trebuie sa fie un numar
%       subunitar in scopul aplearii functiei fir1. De asemenea,
%       construirea vectorului de tip fereastra trebuie facuta pe un
%       suport de lungime M, asadar, apleurile vor fi de forma f =
%       tip_fereastra(M+1); aceste modificari se fac in scopul aplearii
%       fara erori a functiei fir1 care construieste un filtru de lungime
%       M+1 si cere utilizatorului sa ii paseze ca argument un vector
%       fereastra de aceeasi lungime. M trebuie sa fie un numar natural.
%       Se vor crea ferestrele si filtrele corespunzatoare acestora, iar
%       raspunsurile in frecventa vor fi plotate, pentru fiecare fereastra,
%       intr-o figura diferita. Se vor obtine astfel 9 grafice. Pentru
%       ferestrele cu parametru (Cebyshev, Kaiser, Lanczos, Tukey), am
%       variat valorile parametrilor conform enuntului. De asemenea,
%       functia traseaza raspunsul ideal (FTJ) sub forma unei linii
%       punctate rosii. In cazul subpunctului b, se alege o fereastra
%       pentru care se variaza ordinul M. Cele 3 cazuri (3 valori ale lui
%       M) sunt reprezentate cu subplot in figura nr 10. La iesire, functia
%       nu va furniza nicio variabila, ci doar graficele necesare
%       comparatiei caracteristicilor de frecventa. 

%       Daca vor exista erori, programul se va incheia, afisand in linia de
%       comanda Matlab eroarea ce a provocat intreruperea functionarii.

%       Uses: WAR_ERR

%       Autor: Irina COSTACHESCU
%       Creat: Decembrie 18, 2017
%       Updatat: Ianuarie 5, 2018

function tema2 (M,wt1)

%{
SUBPUNCTUL a:
Caracteristicile de frecventa ale filtrelor obtinute cu ajutorul celor
9 ferestre; Pentru ferestrele cu parametru, am variat valorile conform 
enuntului.
%}

f = boxcar(M+1);            %Construire fereastra
h = fir1(M,wt1,f);          %Construire filtru
[H,w] = freqz(h);           %Construire caracteristica de frecventa a filtrului
figure(1)
axis([0 pi 0 1.2]);         %Setare limite axe pentru o reprezentare usor de urmarit
hold on;
plot(w,abs(H));
wt = wt1*pi;       %Am inmultit valoarea subunitara a lui wt cu pi pentru a
                   %putea trasa corect linia in frecventa de taiere.
                   %Mentionez ca wt era subunitar pentru posibilitatea
                   %apelarii functiei fir1.
line([wt wt],[0 1],'Color','red','LineStyle','--');   %Creez liniile pt FTJ  
line([0 wt],[1 1],'Color','red','LineStyle','--');
set(gca,'XTick',[wt],'XTickLabel',{'wt'});
xlabel('w');
ylabel('Amplitudinea raspunsului in frecventa');
title('FTJ tip FIR cu fereastra Rectangulara');

f = triang(M+1);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(2)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
wt = wt1*pi;
line([wt wt],[0 1],'Color','red','LineStyle','--');
line([0 wt],[1 1],'Color','red','LineStyle','--');
set(gca,'XTick',[wt],'XTickLabel',{'wt'});
xlabel('w');
ylabel('Amplitudinea raspunsului in frecventa');
title('FTJ tip FIR cu fereastra Triunghiulara');

f = blackman(M+1);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(3)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
wt = wt1*pi;
line([wt wt],[0 1],'Color','red','LineStyle','--');
line([0 wt],[1 1],'Color','red','LineStyle','--');
set(gca,'XTick',[wt],'XTickLabel',{'wt'});
xlabel('w');
ylabel('Amplitudinea raspunsului in frecventa');
title('FTJ tip FIR cu fereastra Blackman');

f = chebwin(M+1,80);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(4)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
hold on
f = chebwin(M+1,90);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(4)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
f = chebwin(M+1,95);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(4)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
f = chebwin(M+1,100);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(4)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
wt = wt1*pi;
line([wt wt],[0 1],'Color','red','LineStyle','--');
line([0 wt],[1 1],'Color','red','LineStyle','--');
set(gca,'XTick',[wt],'XTickLabel',{'wt'});
xlabel('w');
ylabel('Amplitudinea raspunsului in frecventa');
title('FTJ tip FIR cu fereastra Cebisev');
legend('r = 82dB','r = 90dB','r = 95dB','r = 100dB');

f = hamming(M+1);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(5)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
wt = wt1*pi;
line([wt wt],[0 1],'Color','red','LineStyle','--');
line([0 wt],[1 1],'Color','red','LineStyle','--');
set(gca,'XTick',[wt],'XTickLabel',{'wt'});
xlabel('w');
ylabel('Amplitudinea raspunsului in frecventa');
title('FTJ tip FIR cu fereastra Hamming');

f = hanning(M+1);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(6)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
wt = wt1*pi;
line([wt wt],[0 1],'Color','red','LineStyle','--');
line([0 wt],[1 1],'Color','red','LineStyle','--');
set(gca,'XTick',[wt],'XTickLabel',{'wt'});
xlabel('w');
ylabel('Amplitudinea raspunsului in frecventa');
title('FTJ tip FIR cu fereastra Hanning');

beta = 1;
f = kaiser(M+1,beta);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(7)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
beta = 3;
f = kaiser(M+1,beta);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(7)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
beta = 5;
f = kaiser(M+1,beta);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(7)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
beta = 9;
f = kaiser(M+1,beta);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(7)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
wt = wt1*pi;
line([wt wt],[0 1],'Color','red','LineStyle','--');
line([0 wt],[1 1],'Color','red','LineStyle','--');
set(gca,'XTick',[wt],'XTickLabel',{'wt'});
xlabel('w');
ylabel('Amplitudinea raspunsului in frecventa');
title('FTJ tip FIR cu fereastra Kaiser');
legend('beta = 1dB','beta = 3dB','beta = 5dB','beta = 9dB');

L = 0.5;
f = lanczos(M+1,L);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(8)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
L = 1;
f = lanczos(M+1,L);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(8)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
L = 2;
f = lanczos(M+1,L);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(8)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
L = 3;
f = lanczos(M+1,L);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(8)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
wt = wt1*pi;
line([wt wt],[0 1],'Color','red','LineStyle','--');
line([0 wt],[1 1],'Color','red','LineStyle','--');
set(gca,'XTick',[wt],'XTickLabel',{'wt'});
xlabel('w');
ylabel('Amplitudinea raspunsului in frecventa');
title('FTJ tip FIR cu fereastra Lanczos');
legend('L = 0.5','L = 1','L = 2','L = 3');

alfa = 0.25;
f = tukeywin(M+1,alfa);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(9)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
alfa = 0.47;
f = tukeywin(M+1,alfa);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(9)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
alfa = 0.78;
f = tukeywin(M+1,alfa);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(9)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
alfa = 1;
f = tukeywin(M+1,alfa);
h = fir1(M,wt1,f);
[H,w] = freqz(h);
figure(9)
axis([0 pi 0 1.2]);
hold on;
plot(w,abs(H));
wt = wt1*pi;
line([wt wt],[0 1],'Color','red','LineStyle','--');
line([0 wt],[1 1],'Color','red','LineStyle','--');
set(gca,'XTick',[wt],'XTickLabel',{'wt'});
xlabel('w');
ylabel('Amplitudinea raspunsului in frecventa');
title('FTJ tip FIR cu fereastra Tukey cu alfa = 25%');
legend('alfa = 25%','alfa = 47%','alfa = 78%','alfa = 100% ');


%{
SUBPUNCTUL b: 
Aleg fereastra Chebysev conform rezultatelor exercitiului anterior si 
pastrez valoarea lui r = 100dB.
Aleg valori pentru M = 24, M = 32 si le plotez, alaturi de raspunsul
pentru M = 16 intr-o noua figura pentru a observa diferentele.
%}

M = 16;
f = chebwin(M+1);
h = fir1(M,wt1,f);
wt = wt1*pi;
[H,w] = freqz(h);
figure(10)
subplot(131);
axis([0 pi 0 1.2]);
hold on
plot(w,abs(H));
line([wt wt],[0 1],'Color','red','LineStyle','--');
line([0 wt],[1 1],'Color','red','LineStyle','--');
set(gca,'XTick',[wt],'XTickLabel',{'wt'});
xlabel('w');
ylabel('Amplitudinea raspunsului in frecventa');
title('FTJ tip FIR cu fereastra Chebysev M=16');

M = 24;
f = chebwin(M+1);
h = fir1(M,wt1,f);
wt = wt1*pi;
[H,w] = freqz(h);
subplot(132);
plot(w,abs(H));
line([wt wt],[0 1],'Color','red','LineStyle','--');
line([0 wt],[1 1],'Color','red','LineStyle','--');
set(gca,'XTick',[wt],'XTickLabel',{'wt'});
title('FTJ tip FIR cu fereastra Chebysev M=24');

M = 32;
f = chebwin(M+1);
h = fir1(M,wt1,f);
wt = wt1*pi;
[H,w] = freqz(h);
subplot(133);
plot(w,abs(H));
line([wt wt],[0 1],'Color','red','LineStyle','--');
line([0 wt],[1 1],'Color','red','LineStyle','--');
set(gca,'XTick',[wt],'XTickLabel',{'wt'});
title('FTJ tip FIR cu fereastra Chebysev M=32');

%{
Se observa ca cu cat M este mai mare, cu atat caracteristica in frecventa
se apropie de cea a unui filtru ideal trece jos.
%}


