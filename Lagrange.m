function [ f  z] = Lagrange( x , y )
%Newton Summary of this function goes here
%    x and y are column matrics (points)
%    ex : x = [ 1 ; 2;3] , y = [ 5 ; 6; 7]
%    z are the coffiecents
%   Detailed explanation goes here
  sz = length(x);
  z = zeros(1,sz);
   xminus = '(x -';
  times = '*';
  plus = '+';
  brackets = ')';
  term = ' ';
  expr = ' ' ;
  for i = 1:sz
      Xs = ' ' ;
      flag = 0 ;
      z(i) = y(i);
      for j = 1:sz
          if(i~=j)
               xofi = num2str(x(j));
              z(i)  = z(i)*1/( x(i) - x(j));
               if( flag == 0 )
               Xs = [  Xs xminus xofi brackets ] ;
                 flag = 1;
                 else
                 Xs = [  Xs times xminus xofi brackets ] ;
             end;
          end; 
       end;
       zofi = num2str(z(i));
      if( i ~= 1)
         expr = [ expr plus zofi times Xs];
      elseif ( flag == 0)
          expr = [ expr zofi ];
      else
          expr = [ expr zofi times Xs];
      end;
  end;
  expr;
  f = inline(expr,'x');
end

