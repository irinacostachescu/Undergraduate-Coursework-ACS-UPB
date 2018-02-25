N = 100;
n = 0:N-1;
w0 = pi/8;
w = -pi:0.01:pi;
e = randn(1, N);
x = cos(w0 * n) + e;

figure(1);
stem(n, x);
title('Semnalul x');

%{
Intr-adevar, se observa ca este dificil de estimat periodicitatea
semnalului.
%}

X = freqz(x, 1, w);
p = (1/N) * (abs(X)).^2;
figure(2);
plot(w,p);
title('Densitatea spectrala a semnalului x');

a1 = 0.5;
x = cos(w0 * n) + a1 * e;
X = freqz(x, 1, w);
p = (1/N) * (abs(X)).^2;
figure(3);
subplot(3,1,1);
plot(w,p);
title('Densitatea spectrala a semnalului pentru a=0.5');

% a2 = 1;
% a2 = 1.5;
a2 = 2;
x = cos(w0 * n) + a2 * e;
X = freqz(x, 1, w);
p = (1/N) * (abs(X)).^2;
figure(3);
subplot(3,1,2);
plot(w,p);
title('Densitatea spectrala a semnalului pentru a=2');

a3 = 10;
x = cos(w0 * n) + a3 * e;
X = freqz(x, 1, w);
p = (1/N) * (abs(X)).^2;
figure(3);
subplot(3,1,3);
plot(w,p);
title('Densitatea spectrala a semnalului pentru a=10');

%{
Cu cat crestem valoarea amplificarii zgomotului alb, cu atat ne este mai
greu sa observam punctele de maxim ale spectrului sinusoidei. Zgomotul alb
altereaza semnalul purtator de informatie, adica cosinusul, precum si
densitatea sa de putere spectrala. Asadar, in cadrul valorilor alese,
punctele de maxim se afla in w0 si -w0 (aproximativ 0.4) si se pot distinge
pana la o valoare aproximativa a amplificarii a=2;
%}









