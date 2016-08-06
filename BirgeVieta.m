function [ xr,errors,time,divisionByZero,done ] = BirgeVieta( func,max_it,eps,guess)

tic;
time = 0;
divisionByZero = 0;
done = 0;
errors = 0;
syms x;
symbol(x) = sym(func);
coeff = sym2poly(symbol);
%coeff = sym2ploy(sym(func));
sz = size(coeff);
sz = sz(2);
b(1) = coeff(1);
c(1) = coeff(1);
xr(1) = guess;
errors(1) = 1;


for i = 1:sz
    a(i) = coeff(i);
end

for i = 2: max_it
    

    for j = 2:sz
        
        b(j) = a(j) + b(j-1)*xr(i-1);
        
        if(j == sz)
           break;
        end;
         
         c(j) = b(j) + xr(i-1)*c(j-1); 

    end
    
    
    if(c(sz-1) == 0)
        divisionByZero = 0;
        return;
    end
        
    xr(i) = xr(i-1) - b(sz)/c(sz-1);
   
    errors(i) = abs(xr(i) - xr(i-1));
    
    if(errors(i) < eps)
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

