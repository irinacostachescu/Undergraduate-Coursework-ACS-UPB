N = 10;
n = 0:N-1;
w = pi/3;
phi = pi;
alfa = 2;
j = sqrt(-1);

%Impulsul unitar
imp_unit = eye(1,N);
figure(1);
stem(n,imp_unit);
title('Impulsul unitar');

%Treapta unitate
tr_unit = ones(1,N);
figure(2);
stem(n,tr_unit);
title('Treapta unitate');

%Exponentiala
e = alfa.^n;
figure(3);
stem(n,e);
title('Exponentiala');

%Semnal sinusoidal real
sin_real = sin(w*n + phi);
figure(4);
stem(n,sin_real);
title('Semnal sinusoidal real');

%Semnal sinusoidal complex
sin_compl = exp(j*(w*n+phi));
figure(5);
stem(n,sin_compl);
title('Semnal sinusoidal complex');

%suma a doua semnale
xs = imp_unit + tr_unit;
figure(6);
stem(n,xs);
title('Suma a doua semnale');

%modulatia in timp (produsul la nivel de element)
xm = imp_unit .* tr_unit;
figure(7);
stem(n,xm);
title('Modulatia in timp');

%convolutia
n2 =0: (2*N - 2);
t2 = 1:1:M
xc = conv(imp_unit, tr_unit);
figure(8);
stem(n2,xc);
title('Convolutia');

%semnal aleator lungime N
x = rand(1,N);
x2 = randn(1,N);
%medie a unui semnal aleator
mean(x);

% %AUTO CORELATIA
% r = xcorr(x,'unbiased');
% rx = xcorr (x, 'biased');
% %AUTO COVARIANTA
% r = xcov(x,'unibased');
% rx = xcov(x,'biased');





