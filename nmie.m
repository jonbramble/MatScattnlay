function [Qext,Qsca] = nmie(m,x)
layers = length(m);
nm = Nmax(layers,x,m);

%preallocation of arrays
H_an = zeros(nm,layers);
H_bn = zeros(nm,layers);
phixL = zeros(nm,1);
zetaxL = zeros(nm,1);

% need the mlxl values
z2 = m.*x;
z1 = zeros(1,layers);

for l=2:layers
    z1(l) = m(l-1)*x(l);
end
%special for first layers
H_an(:,1) = D1_nz(nm,z2(1)); 
H_bn(:,1) = D1_nz(nm,z2(1));  

for l=2:layers
    D1z2=D1_nz(nm,z2(l))';
    D1z1=D1_nz(nm,z1(l))';
    D3z2=D3_nz(D1z1,z2(l))';
    D3z1=D3_nz(D1z2,z1(l))';
    G1 = m(l)*H_an(:,(l-1))-m(l-1)*D1z1;
    G2 = m(l)*H_an(:,(l-1))-m(l-1)*D3z1;
    Gt1 = m(l-1)*H_bn(:,(l-1))-m(l)*D1z1;
    Gt2 = m(l-1)*H_bn(:,(l-1))-m(l)*D3z1;
    Qn = Q_nl(nm,x,l,z1(l),z2(l),D1z2,D3z2,D1z1,D3z1)';
    H_an(:,l) = (G2.*D1z2 - Qn.*G1.*D3z2)./(G2-Qn.*G1);
    H_bn(:,l) = (Gt2.*D1z2 - Qn.*Gt1.*D3z2)./(Gt2-Qn.*Gt1);
end

xL = x(layers); %the last layer
phi0 = sin(xL);
zeta0 = sin(xL)-1i*cos(xL);
D1xL = D1_nz(nm,xL);
D3xL = D3_nz(D1xL,xL);

%for the first case
phixL(1) = phi0*(1/(D1xL(1)+1/xL));
zetaxL(1) = zeta0*(1/xL - 1i);
for n=2:nm
    phixL(n) = phixL(n-1)*(n/xL-D1xL(n-1));
    zetaxL(n) = zetaxL(n-1)*(n/xL-D3xL(n-1));
end

%an and bn  - upward recursion
n=1;
mL = m(layers);
an(n) =  ((H_an(n,layers)/mL+n/xL)*phixL(n)-phi0)/((H_an(n,layers)/mL+n/xL)*zetaxL(n)-zeta0);
bn(n) =  ((mL*H_bn(n,layers)+n/xL)*phixL(n)-phi0)/((mL*H_bn(n,layers)+n/xL)*zetaxL(n)-zeta0);

for n=2:nm
    an(n) =  ((H_an(n,layers)/mL+n/xL)*phixL(n)-phixL(n-1))/((H_an(n,layers)/mL+n/xL)*zetaxL(n)-zetaxL(n-1));
    bn(n) =  ((mL*H_bn(n,layers)+n/xL)*phixL(n)-phixL(n-1))/((mL*H_bn(n,layers)+n/xL)*zetaxL(n)-zetaxL(n-1));
end


Qext = 2/(xL^2)*(sum((2*1:nm+1).*(real(an)+real(bn))));   %vector notation here
Qsca = 2/(xL^2)*(sum((2*1:nm+1).*(abs(an).^2+abs(bn).^2)));   %vector notation here

