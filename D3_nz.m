% The function depends on previously calculated array for D1

function [D3n] = D3_nz(D1n,z)
nmax=length(D1n);
D3n = zeros(1,length(nmax));
phizeta = zeros(1,length(nmax));
D3_0 = 1i;
D1_0 = 1/D1n(1);
a=real(z);
b=imag(z);
phizeta0 = 0.5*(1-(cos(2*a)+1i*sin(2*a))*exp(-2*b));

phizeta(1) = phizeta0*(1/z-D1_0)*(1/z-D3_0);
D3n(1) = D1n(1)+1i/phizeta(1);

for n=2:nmax
    phizeta(n) = phizeta(n-1)*(n/z - D1n(n-1))*(n/z-D3n(n-1));
    D3n(n) = D1n(n)+1i/phizeta(n);
end

end