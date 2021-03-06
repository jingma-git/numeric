function [b, c, d] = splinecoeff(x, y)
n = length(x);
v1 = 0;
v2 = 0;

A = zeros(n, n);
b = zeros(n, 1);
for i=1:n-1
    DEL(i) = y(i+1) - y(i);
    del(i) = x(i+1) - x(i);
end

for i=2:n-1
    A(i, i-1:i+1) = [del(i-1) 2 * (del(i-1) + del(i)) del(i)];
    b(i) = 3 * (DEL(i)/del(i) - DEL(i-1)/del(i-1));
end

% set end point conditions
A(1, 1) = 1;
A(n, n) = 1;
c = A \ b; % solve for c coeffs

for i=1:n-1
    b(i) = DEL(i) / del(i) - del(i)/3 * (2*c(i) + c(i+1));
    d(i) = (c(i+1)-c(i)) / (3*del(i));
end