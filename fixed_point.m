function [ xr ,errors, time , done ] = fixed_point( func,max_it,eps,guess )

tic;
errors(1)=1;
toG = '+x';
func = strcat(func,toG);
func = inline(func);
xr(1) = guess;

for i=1:max_it
    xr(i+1)= func(xr(i));
    errors(i+1) = abs(xr(i+1)-xr(i));
    if(errors(i+1) < eps)
        break;
    end
end

sz = size(errors);

if(errors(sz(2)) > eps || isnan(errors(sz(2)) ))
    done = 0;
else
   done = 1;
end 

time=toc*1000;

end