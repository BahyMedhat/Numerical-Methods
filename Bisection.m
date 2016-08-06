function [xu, xl, xr, errors, time, invalidGuesses] = Bisection(func, x_u,  x_l, max_it, eps)


tic;
func=inline(func);
errors(1)=1;
invalidGuesses = 0;
time = 0;
xl(1) = x_l;
xu(1) = x_u;
xr(1) = ( xu(1) + xl(1) ) / 2;

if(func(x_l) * func(x_u) > 0)
     invalidGuesses = 1;
    return;
end

for i = 1:max_it
    
   xr(i) = ( xu(i) + xl(i) ) / 2;
   
   if(func( xr(i) ) * func( xl(i) ) < 0)
       xl(i+1) = xl(i);
       xu(i+1) = xr(i);
   else if (func( xr(i) ) * func( xl(i) ) > 0 )
       xu(i+1) = xu(i);
       xl(i+1) = xr(i);     
   else
       break;
       end
   end
   
   
   if(i == 1)
       continue;
   else
       errors(i) = abs( xr(i) - xr(i-1) );
   
    if(errors(i) < eps)
       break;
    end
   
end 


time = 1000 * toc;

end

