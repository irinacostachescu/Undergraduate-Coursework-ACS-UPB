n = 0 : 200;
w = pi/5;
x = sin(n*w);
figure(1);
stem(n,x);
[rx,lags] = xcorr(x);
figure(2);
plot(lags,rx);
max(rx);
rx(201);

%{
cea mai buna corelatie se obtine bineinteles in rk[0], atunci cand cele
doua semnale nu sunt decalate, si coincid; asadar rk[0] va avea cea mai 
mare valoare, se va afla in pozitia L+1 in vectorul rx, in cazul meu,
rx(201) va conincide cu max(rx), se vor suprapune toate perioadele
sinusoidei (ex: n); 

se observa ca pe plotul lags cu vectorul estimarii corelatiei urmatoarele
puncte de maxim se afla simetric de o parte si de alta a lagului 0, la
distanta de 30. Asadar atunci cand deviez sinusoida cu un lag
egal cu perioada sa, in dreapta sau in stanga, este
acelasi lucru (+30, -30) se vor obtine valori mari si semnificative ale
corelatiei. Acest lucru este simplu de inteles, deoarece deviand cu
exactitate cu o perioada, semnalele vor deveni identice din nou, de data
aceasta suprapunandu-se un numar de n-1 perioade, cea decalata nu mai intra
in calculul corelatiei, produsul dintre punctele sale de sampling
si 0 fiind 0. Cu cat deviez mai mult, -60, -90, respectiv +60, +90, 
similitudinea intre cele doua semnale scade, deoarece acestea vor avea in 
comun din ce in ce mai putine perioade.

Punctele de minim(+15,-15) se datoreaza faptului ca maximului amplitudinii 
semnalului original ii va corespunde minimul amplitudinii semnalului 
decalat, ceea ce va duce la produse negative, insumate rezultand o valoare 
negativa si f mica. La fel ca in cazul maximelor, minimul creste din ce 
in ce mai mult, pe masura ce se deviaza cu multiplii ai lui 15, deoarece
deplasand semnalul, vor coincide mai putine sinusoide.
%}
