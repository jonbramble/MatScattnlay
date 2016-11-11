%Nmax(L,x,m) Calculate the number of terms in the downward recurrence relations
%   Based on previous publications ...
%   L number of layers
%   x array of size parameters for each layer
%   m array of complex relative refractive index parameters 

%   Notes to self - odd choice of indexes in original example
function result = Nmax(L,x,m)
    %check the length of x, m, should equal L
    assert(length(x)==L, 'Size of x must equal the number of layers L')
    assert(length(m)==L, 'Size of m must equal the number of layers L')
    
    nstop = Nstop(x(L));        % find nstop for the largest layer
    mlxl_m1 = zeros(1,(L-1));   % preallocate the array
    mlxl = round(abs(x.*m));
    for a = 2:L   
        mlxl_m1(a) = round(abs(m(a)*x(a-1)));
    end
    %alternative would be to remove first and last values and then do
    %vector product - indexing model is unknown to me
    
    values = [mlxl,mlxl_m1,nstop];
    result = max(values);
    result = result + 15; 
end