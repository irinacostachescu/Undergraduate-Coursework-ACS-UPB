%       File lanczos.M

%       Function: lanczos

%       Call:   f = lanczos(M,L)

%       Creeaza un vector (o fereastra) de tipul Lanczos de lungime M,
%       utilizand parametrul L la fel ca in formula corespunzatoare din
%       pdf-ul cu enuntul temei (4.12). Exponentul L controleaza
%       deschiderea ferestrei si trebuie sa fie mai mare decat 0. M este un
%       numar intreg. Existenta la numitor (in formula (4.12)) a termenului
%       2*n - M + 1 va cauza aparitia unei valori de tip NaN in vectorul f
%       pentru un M impar. Acest lucru se solutioneaza in linia 37 prin
%       atribuirea elementului din mijlocul vectorului valoarea 1. Asadar,
%       in cazul M par, toate elementele ferestrei vor fi calculate cu
%       ajutorul formulei mentionate, iar in cazul M impar, vor fi
%       calculate in acelasi mod toate elementele diferite de cel din
%       mijloc, acesta primind valoarea 1, evitand astfel problema cauzata
%       de o impartire la 0.

%       Daca vor exista erori, programul se va incheia, afisand in linia de
%       comanda Matlab eroarea ce a provocat intreruperea functionarii.

%       Uses: WAR_ERR

%       Autor: Irina COSTACHESCU
%       Creat: Decembrie 18, 2017
%       Updatat: Ianuarie 5, 2018

function f = lanczos (M,L)
n = 0:M-1;
f = zeros(1,length(n));
    for i = 1:M
        f(i) = (sin((2*pi)*(2*n(i)-M+1)/(2*(M-1))))/(2*pi*(2*n(i)-M+1)/(2*(M-1)));
        f(i) = power(f(i),L);
        if (mod(M,2) ~= 0)
             f(((M-1)/2) + 1) = 1;
        end
    end
end

    
        