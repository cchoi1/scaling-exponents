function a = calcConserve(arrOfChildrenLengths, parentLength)
%calcConserve: function that calculates the scaling exponents a and b using the
%conservation-based method
%
%INPUT:
% rk:    radius or length of the parent vessel
% rk1:   radius or length of the child vessel
%
%OUTPUT:
%  a:   scaling exponent
%
%EX:
% rk = 0.2
% rk1 = 0.1
% a = calcConserve(rk, rk1)
%	
%	Caroline Choi, 8/23/17
%============================================================
syms x
sum=0;
for i=1:length(arrOfChildrenLengths)
    sum = sum + arrOfChildrenLengths(i)^(x);
end
eqn = parentLength^(x) == sum;
a = solve(eqn,x);
a = double(a);
a = 1/a;
end