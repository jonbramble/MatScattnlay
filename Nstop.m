function result = Nstop(xL) 
    if xL <= 8
        result = round(xL + 4*xL^(1/3) +1);
    elseif xL <= 4200
        result = round(xL + 4.05*xL^(1/3) + 2);
    else
        result = round(xL + 4*xL^(1/3) + 2);
    end
end