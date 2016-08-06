function [xu, xl, xr, errors, time , divisonByZero, invalidGuesses] = false_position(fn, x_u,  x_l, max_it, eps)

tic;
time  = 0;
fn = inline(fn);
xr(1) = x_l;
xu(1) = x_u;
xl(1) = x_l;
errors(1) = 1;
divisonByZero = 0;
invalidGuesses = 0;

if(fn(x_l) * fn(x_u) > 0)
     invalidGuesses = 1;
    return;
end


for (i = 1 : 1 : max_it)
    
    if(fn(xu(i)) - fn(xl(i)) == 0)
        divisonByZero = 1;
        break;
    end
    
    xr(i) = ((xl(i) * fn(xu(i))) - (xu(i) * fn(xl(i)))) / (fn(xu(i)) - fn(xl(i)));

    if(i > 1)
        errors(i) = abs((xr(i) - xr(i - 1)));
        if(errors(i) < eps)
            break;
        end
    end
    
    if(fn(xr(i)) * fn(xl(i)) > 0)
        xu(i + 1) = xu(i);
        xl(i + 1) = xr(i);
    
    else if(fn(xr(i)) * fn(xl(i)) < 0)
        xu(i + 1) = xr(i);
        xl(i + 1) = xl(i);
    
   else
        break;
        end
    end
    
end

time = 1000 * toc;

end