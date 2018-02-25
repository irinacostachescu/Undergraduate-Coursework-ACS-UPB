function tema6d(e,x)
rx = xcorr(x);
a = 0.01:0.1:2;
for i=1:length(a)
    v = a(i)*e;
    rv = xcorr(v);
    SNR(i) = 20 * log(abs(rx/rv));
end
plot(a,SNR)
title('Graficul SNR');
%{
Din grafic se observa ca odata cu cresterea amplitudinii a, raportul
SNR scade. Acest lucru este normal deoarece SNR reprezinta raportul dintre
puterea semnalului util si cea a zgomotului. Este firesc asadar ca odata ce
puterea zgomotului creste, raportul sa scada.
%}
end

