teta1 = pi/3;
r1 = 0.8;
teta2 = pi;
r2 = 0.95;
teta3 = (pi)/2;
r3 = 0.75;
a = [1 -r2*cos(teta2)-2*cos(teta1)*r1 (2*cos(teta1)*r1*r2*cos(teta2))+(r1^2) -(r1^2)*r2*cos(teta2)];
b = [1 -2*cos(teta3) r3^2];

w = 0:0.01:pi;
H1 = freqz(b, a, w);

figure(1);
zplane(b,a);

figure(2);
freqz(b,a);

figure(3);
plot(w,abs(H1));
grid on;