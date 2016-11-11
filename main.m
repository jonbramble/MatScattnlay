Nm = 1.33;

%lambda = linspace(300,700);
lambda = gold(:,1)
r1 = 40;
r2 = 41;

r = [r1 r2];

for l=1:length(lambda)
m = [(gold(l,2)+1i*gold(l,3))/Nm 1.45/Nm];
x = 2*pi*Nm*r/lambda(l);
[Qext(l), Qsca(l)] = nmie(m,x);
end

plot(lambda,Qsca,'r')