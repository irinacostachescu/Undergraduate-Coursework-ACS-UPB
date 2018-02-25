%{
Am ales w0 si N astfel incat suportul sa contina cel putin 5 
perioade ale sinusoidei.
%}

N = 100;
n = 0:N-1;
w1 = pi/8;
w2 = pi/3;
x1 = cos(w1*n);
x2 = cos(w2*n);
x = x1 + x2 ;
figure(1);
subplot(311);
stem(n, x);
title('Semnalul x');
subplot(312);
stem(n, x1);
title('Semnalul cos(w1*n)');
subplot(313);
stem(n,x2);
title('Semnalul cos(w2*n)');

%{
Perioada lui x1 este 16, iar perioada lui x2 este 6;
Perioada intregului semnal va fi cel mai mic multiplu comun al perioadelor
celor doua semnale care il compun, asadar aceasta va fi egala cu 48;
%}

w = -pi:0.01:pi;
X = freqz(x, 1, w);
figure(2);
plot(w, abs(X));
title('Spectrul semnalului x');

%{
Conform formulei lui Euler, cosinusul de descompune ca suma de doua semnale
exponentiale. Avand doua cosinusuri, vor rezulta 4 semnale exponentiale,
fiecare avand un punct de maxim. Observam ca spectrul semnalului x prezinta
intr-adevar 4 puncte de maxim corespuncatoare valorilor w1, -w1, w2, -w2, 
asadar graficul obtinut este conform asteptarilor bazate pe rezultatele
exercitiului 1.
%}

x1 = 5*sin(w1*n);
x2 = 2*sin(w2*n);
x = 5*sin(w1*n) + 2*sin(w2*n);
X = freqz(x, 1, w);

figure(3);
subplot(311);
stem(n,x1);
title('Semnalul 5*sin(w1*n)');
subplot(312);
stem(n,x2);
title('Semnalul 2*sin(w2*n)');
subplot(313);
stem(n,x);
title('Semnalul x');

figure(4);
plot(w,abs(X));
title('Spectrul semnalului');

%{
Analog punctului anterior, perioada semnalului este cmmmc al celor doua
perioade, asadar perioada este 48
%}

w1 = pi/2;
w2 = pi/2 + 0.01;

x1 = 5*sin(w1*n);
x2 = 2*sin(w2*n);
x = 5*sin(w1*n) + 2*sin(w2*n);
X = freqz(x, 1, w);

figure(5);
subplot(311);
stem(n,x1);
title('Semnalul 5*sin(w1*n)');
subplot(312);
stem(n,x2);
title('Semnalul 2*sin(w2*n)');
subplot(313);
stem(n,x);
title('Semnalul x');
x = 5*sin(w1*n) + 2*sin(w2*n);
X = freqz(x, 1, w);

%{
Perioada semnalului este 4
%}

figure(6);
plot(w,abs(X));
title('Spectrul semnalului');

%{
Se oberva ca graficul nu va mai prezenta 4 puncte de maxim, desi cele doua 
sinusoide se descompun si ele, la fel ca si semnalele de tip cos in suma
de cate 2 exponentiale. Prezenta a numai doua puncte de maxim in graficul
spectrului semnalului este cauzata de diferenta foarte mica dintre valorile
w1 si w2, aceasta facand ca punctele de maxim din w1 si w2, repspectiv -w1
si -w2 sa se suprapuna.
%}

