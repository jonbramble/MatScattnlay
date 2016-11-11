m = [1.0,1.1];
x = [0.1,0.11];

layers = 2;
nm = Nmax(layers,x,m);

H_an = zeros(nm,layers);
H_bn = zeros(nm,layers);
D1z1 = zeros(nm,layers);
D1z2 = zeros(nm,layers);
D3z1 = zeros(nm,layers);
D3z2 = zeros(nm,layers);

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