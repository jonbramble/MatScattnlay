% return an nmax length array for the Qn values for each layer

function [Qn] = Q_nl(nmax,x,z1,z2,D1z2,D3z2,D1z1,D3z1)
 a1 = real(z1);
 b1 = imag(z1);
 a2 = real(z2);
 b2 = real(z2);
 
 % do case for n=1
 for n=2:nmax
     Qn=n
     
 end