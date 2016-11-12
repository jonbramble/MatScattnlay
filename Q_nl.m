% return an nmax length array for the Qn values for each layer
% nmax is the number of n we need
% x an array of size parameters
% z1 x(l)m(l-1) 
% z2 x(l)m(l)
% l the current layer number
% D1 previously calculated Ricatti-Bessel Derivatives

function [Qn] = Q_nl(nmax,x,l,z1,z2,D1z2,D3z2,D1z1,D3z1)
 a1 = real(z1);
 b1 = imag(z1);
 a2 = real(z2);
 b2 = real(z2);
 
 Qn = zeros(1,nmax);
 
 D3_0 = 1i;
 
 % do case for n=1
 Q0 = ((exp(-2i*a1)-exp(-2*b1))/(exp(-2i*a2)-exp(-2*b2)))*exp(-2*(b2-b1));
 %Qn(1) = Q0*((x(l-1)/x(l))^2)*(((z2*D1z2(1)+1)*(1-z2*D3_0))/((z1*D1z1(1)+1)*(1-z1*D3_0)));
 Qn(1) = Q0*((x(l-1)/x(l))^2)*(((z2*D1z2(1)+1)/(z1*D1z1(1)+1))*((1-z2*D3_0)/(1-z1*D3_0)));
 for n=2:nmax
     Qn(n) = Qn(n-1)*((x(l-1)/x(l))^2)*(((z2*D1z2(1)+n)/(z1*D1z1(1)+n))*((n-z2*D3z2(n-1))/(n-z1*D3z1(n-1))));
 end