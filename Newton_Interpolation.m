function [f , z ] = Newton_Interpolation( x , y )
%Newton Summary of this function goes here
%    x and y are column matrics (points)
%    ex : x = [ 1 ; 2;3] , y = [ 5 ; 6; 7]
%   Detailed explanation goes here
  x=x';
  y = y';
  sz = length(x);
  z = zeros(sz,sz-1);
  z([2:sz],1) = (y([2:sz]) - y([1:sz-1]))./(x([2:sz]) - x([1:sz-1]));
  for i =1:sz-2
     z([i+2:sz],i+1) = (z([2+i:sz],i) - z([1+i:sz-1],i))./(x([i+2:sz]) - x([1:sz-i-1]));
  end
  z = [ y z];
  var = z .* eye(sz,sz);
  var = diag(var);
  xminus = '*(x -';
  times = '*';
  plus = '+';
  brackets = ')';
  term = ' ';
  Xs = ' ' ;
  expr = ' ' ;
  for i=1:sz
      zofi = num2str(var(i));
      if(i==1)
          expr = [expr zofi];
      else
        xofi = num2str(x(i-1));
        Xs = [  Xs xminus xofi brackets ] ;
        term = [ zofi  Xs ];
        expr = [ expr plus term];
      end;
    end;
  f = inline(expr,'x');
end



