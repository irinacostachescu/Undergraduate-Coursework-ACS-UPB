load 'xilo.mat'
[x,f] = auread('xilo');
y = x(8000:10000)
n = 0:2000;
figure(1);
stem(n,y)
[ry,lags] = xcorr(y);
figure(2);
plot(lags,ry);
title('Xilo');

%{
Pseudo perioada semnalului xilo este aprozimativ 30.
La fel ca la punctul precedent se observa ca maximele secventei de
autocorelatie se alfa simetric de o parte si de alta a lagului 0 (pct max)
Se diminueaza periodic(perioada semnalului) pe masura ce deviatia creste 
(mai putine sinusoide in comun).
%}




