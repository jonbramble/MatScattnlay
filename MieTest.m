% test Nstop

xLsmall = 6;
xLmedium = 2000;
xLlarge = 6000;

rl = logspace(0.1,4);
Nm = 1;
lambda = 600; 
xl = (2*pi*Nm*rl)/lambda;
ml = ones(1,length(rl))*1.33+0i;

%% Test 1 - Nstop
result = Nstop(xLsmall);
assert(result == 14 )

%% Test 2 - Nstop
result = Nstop(xLmedium);
assert(result == 2053 )

%% Test 3 - Nstop
result = Nstop(xLlarge);
assert(result == 6075 )

%% Test 4 - Nmax 
Nmax(length(rl),xl,ml)
