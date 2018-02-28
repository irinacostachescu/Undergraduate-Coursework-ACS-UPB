load 'xilo.mat'
[x,f] = auread('xilo');
y = x(8000:10000)
n = 0:2000;
figure(1);
stem(n,y);
title('Graficul semnalului xilo');

w = -pi:0.01:pi;
X = freqz(y, 1, w);

figure(2);
plot(w, abs(X));
title('Spectrul semnalului xilo');

% %Frecventa in care se afla punctul de maxim este 0.2084
% %Stim ca perioada T = 2*pi/omega.Asadar:
% omega_max = 0.2084;
% perioada = 2*pi/omega_max %perioada = 30.1496;
% 
y = x(9500:10000);
X = freqz(y, 1, w);
figure(3);
plot(w, abs(X));
title('Spectrul semnalului xilo pemtru ultimele 500 esantioane');

%{
Un semnal are un spectru armonic daca si numai daca acesta este periodic.
Spectrul armonic contine componente frecventiale care sunt multipli de
numere intregi ale frecventei fundamentale. Aceste frecvente se numesc
armonice. Xilo este periodic in partea lui finala, de aceea putem observa
prezenta armonicelor
%}
