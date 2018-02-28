
lynx
an = year;
valori = lynxv;

figure(1);
subplot(2,3,1);
plot(an, valori);
title('Graficul relatiei prada-pradator');

w = -pi:0.01:pi;
X = freqz(valori, 1, w);

subplot(2,3,4);
plot(w, abs(X));
title('Spectrul relatiei prada-pradator');

%{
Frecventa in care se afla punctul de maxim este 0.6484. Perioada este 
T = 2*pi/w = 9.6903;
%}

%Primii 100 de ani:
an1 = an(1:100, 1);
valori1 = valori(1:100, 1);

subplot(2,3,2);
plot(an1, valori1);
title('Graficul relatiei prada-pradator pentru primii 100 de ani');

%{
Frecventa in care se afla punctul de maxim este 0.6584. Perioada este 
T = 2*pi/w = 9.5431;
%}

X1 = freqz(valori1, 1, w);
subplot(2,3,5);
plot(w, abs(X1));
title('Spectrul relatiei prada-pradator pentru primii 100 de ani');

%Primii 50 de ani:
an2 = an(1:50, 1);
valori2 = valori(1:50, 1);

subplot(2,3,3);
plot(an2, valori2);
title('Graficul relatiei prada-pradator pentru primii 50 de ani');

X2 = freqz(valori2, 1, w);

subplot(2,3,6);
plot(w, abs(X2));
title('Spectrul relatiei prada-pradator pentru primii 50 de ani');

%{
Frecventa in care se afla punctul de maxim este 0.5784. Perioada este 
T = 2*pi/w = 10.8630;
%}

