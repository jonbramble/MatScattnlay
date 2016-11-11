Nm = 1.33;

%lambda = linspace(300,700);
r1 = 20;
r2 = 21;

r = [r1 r2];

for l=1:length(lambda)
    m = [(ag_n(l)+1i*ag_k(l))/Nm 1.45/Nm];
    x = 2*pi*Nm*r/lambda(l);
    [Qext(l), Qsca(l)] = nmie(m,x);
end

plot(lambda,Qsca,'r')