N = 100;
x = randn(1,N);
mean(x);
L = 6;
[rx, lags] = xcorr(x,L,'biased')
figure(1);
plot(lags,rx);
title('Autocorelatia vs time delay');


% Cresterea preciziei de estimare se realizeaza pe baza cresterii
% numarului de date N
% E normal ca corelatia dintre un semnal si el insusi(autocorelatia)
% sa aiba cea mai mare valoare atunci cand semnalul coincide
% cu el insusi, adica decalajul dintre cele doua este de valoare 0;


