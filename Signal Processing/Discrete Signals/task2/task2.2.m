function [x] = tema22 (w,Ts,M)
t = 0:M;
xa = sin(w*t);
for i = 1 : M
    x(i) = xa(i * Ts);
end
end

% ESANTIONARE = discretizarea variatiei in timp a semnalului
% x[n] = xa (nT)
% unde x[n] este semnalul discret obtinut prin retinerea valorilor 
% semnalului analogic xa(t) la fiecare T secunde.
% Intervalul  de timp T dintre doua esantioane succesive se numeste 
% perioada de esantionare sau interval de esantionare. Inversa acestei 
% marimi (1/T=Fs) se numeste viteza sau rata de esantioanare 
% (esantioane /secunda) sau frecventa de esantionare (Hertz).


    
