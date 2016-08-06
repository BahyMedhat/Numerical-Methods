function [ xr, errors , time , divisionByZero ,  done] = Secant( func, max_it, eps, guessZero, guessOne)

tic;
xr(1) = guessZero;
xr(2) = guessOne;
divisionByZero = 0;
done = 1;
time = 0;
errors(1)=1;
errors(2)=1;
func = inline(func);

for i = 3:max_it
    
    if( func(xr(i-2)) - func(xr(i-1)) == 0)
        divisionByZero = 1;
        return;
    end
    
    xr(i) = xr(i-1) - ( func(xr(i-1)) * ( xr(i-2) - xr(i-1) ) ) /  ( func( xr(i-2) ) - func( xr(i-1) ) );
    errors(i) = abs( xr(i)-xr(i-1) );
    
    if(errors(i) <= eps)
        break;
    end
    
end

sz = size(errors);

if(errors(sz(2)) > eps || isnan(errors(sz(2)) ))
    done = 0 ;
else
    done = 1;
end 


time = toc*1000;




end