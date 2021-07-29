%% Input
% d: degree of polynomial
% c: d+1 coefficients
% x: input
% b: d base points
%% Output
% y: value y of polynomial at x
function y = nest(d, c, x, b)
if nargin<4
    b = zeros(d, 1);
end
y = c(d+1);
for i = d:-1:1
    y = y.*(x-b(i)) + c(i);
end
