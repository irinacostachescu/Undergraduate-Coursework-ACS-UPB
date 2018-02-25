N = 100;
n = 0:N-1;
w0 = pi/8;
phi = pi;
x = cos(w0 * n + phi); 
w = -pi:0.01:pi;
X = freqz(x, 1, w);
figure(1);
plot(w, abs(X));
title('Spectrul semnalului x');

%{
Se observa ca graficul spectrului semnalului este simetric fata de axa
verticala. Mai exact, |X(w)| = |X(-w)|.
%}


phi1 = 0;
phi2 = pi/16;
phi3 = pi/2;

x1 = cos(w0 * n + phi1);
X1 = freqz(x1, 1, w);
figure(2);
plot(w,abs(X1));
title('Spectrul pentru phi = 0');

x2 = cos(w0 * n + phi2);
X2 = freqz(x2, 1, w);
figure(3);
plot(w,abs(X2));
title('Spectrul pentru phi = pi/16');

x3 = cos(w0 * n + phi3);
X3 = freqz(x3, 1, w);
figure(4);
plot(w,abs(X3));
title('Spectrul pentru phi = pi/2');













