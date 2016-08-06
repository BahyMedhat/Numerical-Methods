function [ xr,errors,time,divisionByZero,done ] = Newton( func,max_it,eps,guess )

tic;
xr(1) = guess;
divisionByZero = 0;
errors(1)=1;
time = 0;
done = 1;
dfunc = diff(sym(func),1);
dfunc = inline(dfunc);
func = inline(func);

for i=1:max_it
    
    if(dfunc(xr(i)) == 0)
        divisionByZero = 1;
        return;
    end
    
    xr(i+1) = xr(i) - ( func(xr(i)) / dfunc( xr(i) ) );
    errors(i+1) = abs( xr(i+1) - xr(i) );
    
    if(errors(i+1) < eps)
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

