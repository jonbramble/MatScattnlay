function [Dn] = D1_nz(nmax,z)
Dn=zeros(1,nmax);
Dn(nmax)=0;
%downward recurance
for n=nmax:-1:2
    ndz = n/z;
    Dn(n-1) = ndz - 1/(Dn(n)+ ndz);
end

end
    
    