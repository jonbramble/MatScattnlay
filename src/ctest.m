L=1;
lm = 500;
m = [ag(lm)/Nm];
x = 2*pi*Nm*r/lambda(lm);
z1=m*x;
[Qext, Qsca] = nmie(L,x,m);



%D1_nz(20,z1)'