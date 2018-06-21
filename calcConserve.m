function a = calcConserve(arr_children_lengths, parent_length)
%Calculates the scaling exponents a and b using the
%conservation-based method.
%
%INPUT:
% arrOfChildrenLengths: array of children radii or lengths
% parentLength: parent vessel radius or length
%
%OUTPUT:
%  a: scaling exponent
%	
%Caroline Choi
%============================================================
syms x
sum=0;
for i=1:length(arr_children_lengths)
    sum = sum + arr_children_lengths(i)^(x);
end
eqn = parent_length^(x) == sum;
a = vpasolve(eqn,x);
a = double(a);
a = 1/a;
end