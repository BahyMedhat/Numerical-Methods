function [xu, xl, xr, errors, time] = General(func , lower , upper , eps , max_iterations)

tic;
len = (upper-lower)/1000;
notDone = 1;

while lower <= upper & notDone
    [xu, xl, xr, errors, tim, invalidGuesses] = Bisection(func,lower+len,lower,max_iterations,eps);
    if(invalidGuesses == 0)
        notDone = 0;
    end
    lower = lower + len;
end
time = toc*1000;
end

