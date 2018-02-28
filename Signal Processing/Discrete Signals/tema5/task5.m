x = randn(1,100);

a = mean(x); 
b = var(x); 
p =@(e)1/((2*pi*b)^1/2)*exp(-((e-a).^2)./(2*b^2))* length(x); 
hist(x);
hold on
fplot(p, [min(x) max(x)]);

%Distributia experimentala coincide cu  graficul densitatii de 
%probabilitate.
