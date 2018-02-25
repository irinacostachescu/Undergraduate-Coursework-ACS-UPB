load 'sunet_a.mat'
[x1,f1] = auread('sunet_a');
load 'sunet_i.mat'
[x2,f2] = auread('sunet_i');
n=1:length(x1);
figure(1);
stem(n,x1);
title('Sunet a');
figure(2);
stem(n,x2);
title('Sunet i');
load 'sunet_s.mat'
[x3,f3] = auread('sunet_s');
n2 = 1:length(x3);
figure(3);
stem(n2,x3);
title('Sunet s');
mean(x3);
[rx,lags] = xcorr(x3);
figure(4);
stem(lags,rx);
title('Secventa de autocorelatie sunet s');
max(rx);
min(rx);
figure(5);
[rx1, lags1] = xcorr(x1);
stem(lags1,rx1);
title('Secventa de autocorelatie sunet a');
figure(6);
[rx2, lags2] = xcorr(x2);
stem(lags2,rx2);
title('Secventa de autocorelatie sunet i');

%{
Semnalul s are medie nula;
Respecta definita 1.27  toate elementele sale fiind aproximativ egale cu 0.
In schimb nu respecta cea de-a doua relatie, observand ca graficul din
figura 3 depaseste axa Ox in partea negativa a axei Oy. Asadar, desi
amplitudinea semnalului este aproximativ constanta pe intreaga durata a
acestuia, acesta nu constituie un semnal de tip zgomot alb.

in 1.28 toate elementele rx ar trebui (lambda^2)*imp_unit(0) = lamda^2.
Din acest produs, stiind ca impulsul unitar este 1 in t = 0 si in rest 0,
rezulta ca restul elementelor lui rx ar trebui sa fie 0, lucru ce nu se
intampla. Asadar, s nu este un zgomot alb.(re[p,q]=0, oricare p diferit q)
%}

