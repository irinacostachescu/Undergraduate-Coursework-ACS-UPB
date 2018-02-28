load('sunspot.dat');

an = sunspot(:,1);
nr_pete = sunspot(:,2);

figure(1);
plot(an, nr_pete);
title('Graficul numarului petelor solare');

w = -pi:0.01:pi;
X = freqz(nr_pete, 1, w);
figure(2);
plot(w, abs(X));
title('Spectrul TF a functiei sunspot');

%{
Frecventa in care se afla punctul de maxim este 0.5684, asadar perioada
T = 2*pi/w va fi egala cu 11.05, adica aproximativ 11.
%}

%Pentru o durata de 50 de ani
an1 = an(1:50, 1);
nr_pete1 = nr_pete(1:50, 1);
figure(3); 
subplot(221);
plot(an1, nr_pete1);
title('Graficul numarului petelor solare pentru primii 50 de ani');
X1 = freqz(nr_pete1, 1, w);
subplot(222);
plot(w, abs(X1));
title('Spectrul petelor solare pentru primii 50 de ani');
 
%Pentru o durata de 100 de ani
an1 = an(1:100, 1);
nr_pete1 = nr_pete(1:100, 1);
figure(3); 
subplot(223);
plot(an1, nr_pete1);
title('Graficul numarului petelor solare pentru primii 100 de ani');
X1 = freqz(nr_pete1, 1, w);
subplot(224);
plot(w, abs(X1));
title('Spectrul petelor solare pentru primii 100 de ani');
  

%{
Scaderea duratei semnalului presupune modificarea frecventei
corespunzatoare celui mai inalt varf a TF, precum si a valorii de maxim 
a acesteia
%}
