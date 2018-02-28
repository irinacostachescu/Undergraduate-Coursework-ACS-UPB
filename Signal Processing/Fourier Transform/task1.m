
%{
Am ales w0 si N astfel incat suportul sa contina cel putin 5 
perioade ale sinusoidei.
%}

N = 100;
%N = 250;
n = 0:N-1;
w0 = pi/8;
x = exp(j*w0*n);
figure(1);
stem(n,x);
title('Sinusoida complexa');

%Transformata Fourier a sinusoidei complexe
w = (-pi):0.01:(pi);
x = exp(j*w0*n);
X = freqz(x,1,w);
figure(2);
plot(w,abs(X));
title('Spectrul semnalului x');



