%Semnal continuu
function tema23(w,Ts,M,t,x)
 
 xa = sin(w*t);
 n = 0:(M-1);

%Plotarea celor doua grafice
figure;
plot(t,xa,'--');
hold on
stem(n,x);

