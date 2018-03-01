M = 50;
Ts = 1;
t=0:0.1:M;

%A
w = pi/15;
x = tema22(w,Ts,M);
figure(1);
tema23(w,Ts,M,t,x);
title('Subpunctul a, w = pi/15');

%B
 w = (3*pi)/15;
 %w = (4*pi)/15; %k=2;
 %w = (8*pi)/15; %k=4;
 x = tema22(w,Ts,M);
 figure(2);
 tema23(w,Ts,M,t,x);
 title('Subpunctul b, w = 3*pi/15');

% w = omega, 2pi/omega = T , omega = 2kpi/N =>> N = T * K;
% Ceea ce inseamna ca k reprezinta numarul de perioade ale semnalului
% sinusoidal continuu care corespund unei perioade a semnalului sinusoidal
% discret

%C
 w = 1;
 x = tema22(w,Ts,M);
 figure(3);
 tema23(w,Ts,M,t,x);
 title('Subpunctul c, w = 1');

%D
 w1 = pi/3;
 x = tema22(w1,Ts,M);
 figure(4);
 tema23(w1,Ts,M,t,x);
 title('w1 = pi/3');
 w2 = 2*pi + pi/3;
 x = tema22(w2,Ts,M);
 figure(5);
 tema23(w2,Ts,M,t,x);
 title('w2=2pi + pi/3');

    
%{
 Pulsatie mai mare inseamna frecventa mai mare, de aceea in cazul w2
 graficul contine un numar mai mare de sinusoide; In discret, acest lucru
 nu este observabil deoarece 2pi este perioada semnalului sinusoidal
 %}


