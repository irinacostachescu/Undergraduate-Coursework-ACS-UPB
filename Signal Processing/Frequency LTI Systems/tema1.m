%teta = pi/3;
teta = (3*pi)/4;
%Valorile lui r din intervalul [0,1]
r1 = 0.1;
r2 = 0.4;
r3 = 0.7;
r4 = 1;

w = -pi:0.01:pi;

b1 = [1 -r1*exp(j*teta)];
b2 = [1 -r2*exp(j*teta)];
b3 = [1 -r3*exp(j*teta)];
b4 = [1 -r4*exp(j*teta)];

H1 = freqz(b1, 1, w);
H2 = freqz(b2, 1, w);
H3 = freqz(b3, 1, w);
H4 = freqz(b4, 1, w);

%Caracteristica de frecventa a filtrului 
figure(1);
freqz(b1,1,w);
hold on;
freqz(b2,1,w);
hold on;
freqz(b3,1,w);
hold on;
freqz(b4,1,w);
hold on;
lines = findall(gcf,'type','line');
set(lines(4),'color','black')
set(lines(3),'color','red')
set(lines(2),'color','green')
legend('r = 0.1','r = 0.4','r = 0.7', 'r = 1');
title('Caracteristica de frecventa a filtrului');

%Amplitudine adimensionala
figure(2);
plot(w,abs(H1),'k');
xlim([-pi pi]);
hold on;
plot(w,abs(H2),'r');
xlim([-pi pi]);
hold on;
plot(w,abs(H3),'g');
xlim([-pi pi]);
hold on;
plot(w,abs(H4),'b');
xlim([-pi pi]);
hold on;
grid on;
legend('r = 0.1','r = 0.4','r = 0.7', 'r = 1');
title('Amplitudine adimensionala');

%Amplitudine in dB
figure(3);
plot(w,20*log10(abs(H1)),'k');
xlim([-pi pi]);
hold on;
plot(w,20*log10(abs(H2)),'r');
xlim([-pi pi]);
hold on;
plot(w,20*log10(abs(H3)),'g');
xlim([-pi pi]);
hold on;
plot(w,20*log10(abs(H4)),'b');
xlim([-pi pi]);
grid on;
legend('r = 0.1','r = 0.4','r = 0.7', 'r = 1');
title('Amplitudine in decibeli');

%Pozitiile zerourilor
figure(4);
zplane(b1, 1);
axis([-2,2,-2,2]);
hold on;
zplane(b2, 1);
axis([-2,2,-2,2]);
hold on;
zplane(b3, 1);
axis([-2,2,-2,2]);
hold on;
zplane(b4, 1);
axis([-2,2,-2,2]);
grid on;
title('Pozitii zerouri');

