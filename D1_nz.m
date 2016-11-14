function [Dn] = D1_nz(nmax,z)
Dn=zeros(1,nmax+1);
Dn(nmax+1)=0;
%downward recurance
for n=(nmax+1):-1:2
    ndz = n/z;
    Dn(n-1) = ndz - 1/(Dn(n)+ ndz);
end

Dn(nmax+1)=[];  %remove the last value
end
    
    