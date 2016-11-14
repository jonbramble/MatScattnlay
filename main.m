import_ndata
ag = ag_n + 1i*ag_k;

Nm = 1.33;  %Ambient index

r1 = 35;    %inner radius
r2 = 21;

r = [r1];   %array of particle and shell radii

Qext=zeros(1,length(lambda));   %preallocate for Qs
Qsca=zeros(1,length(lambda));

for lm=1:length(lambda)          %loop over lambda
    %m = [(ag_n(l)+1i*ag_k(l))/Nm 1.45/Nm];
    m = [ag(lm)/Nm];
    x = 2*pi*Nm*r/lambda(lm);
    [Qext(lm), Qsca(lm)] = nmie(1,x,m);
end

plot(lambda,Qext,'r')
hold on
plot(lambda,Qsca,'k')