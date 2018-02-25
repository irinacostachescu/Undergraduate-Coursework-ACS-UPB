N = 300;
n = 0:N-1;
w = -pi:0.01:pi;

e = randn(1, N);

X = freqz(e, 1, w);
p = (1/N) * (abs(X)).^2;
figure(1);
subplot(3,1,1);
plot(w, p);
title('Densitatea de putere spectrala pt. N=300');
%{
Un semnal poate fi exprimat ca o combinatie de sinusuri si cosinusuri de 
diferite perioade si amplitudini. Aceasta descompunere ne poate ajuta sa 
aflam informatii importante despre comportamentul periodic al intregului 
semnal. Periodograma este utilizata pentru a identifica perioadele sau 
frecventele dominante cu scopul de a decide ce semnale din descompunerea 
semnalului initial ofera informatie importanta si ce semnale nu contin o 
cantitate atat de mare de informatie. Semnalele mai putin importante pot fi
eliminate din descompunere. Pentru un semnal random, asa cum este si cel 
din exercitiul prezentat, toate componentele sinus sau cosinus sunt de 
egala importanta, de aceea graficul periodogramei variaza in jurul unei 
anumite constante. Daca semnalul initial are o sinusoida puternica la o 
anumita frecventa, atunci, la acea frecventa, pe graficul periodogramei 
se va regasi un punct de maxim pronuntat.
%}

N = 500;
e = randn(1, N);
X = freqz(e, 1, w);
p = (1/N) * (abs(X)).^2;
figure(1);
subplot(3,1,2);
plot(w, p);
title('Densitatea de putere spectrala pt. N=500');


N = 700;
e = randn(1, N);
X = freqz(e, 1, w);
p = (1/N) * (abs(X)).^2;
figure(1);
subplot(3,1,3);
plot(w, p);
title('Densitatea de putere spectrala pt. N=700');

