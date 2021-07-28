function [mat, err] = beam(n)
L = 2;
E = 1.3 * 10 ^ 10;
I = 0.3 * 0.03^3/12;
h = L / n;

a = [1, -4, 6, -4, 1];
A = sparse(n, n);
A(1, 1) = 16;
A(1, 2) = -9;
A(1, 3) = 8/3;
A(1, 4) = -1/4;

A(2, 1) = -4;
A(2, 2) = 6;
A(2, 3) = -4;
A(2, 4) = 1;

for i=3:n-2
    k = i - 2;
    for j=1:5
        A(i, k) = a(j);
        k = k + 1;
    end
end

A(n-1, n-3) = 16/17;
A(n-1, n-2) = -60/17;
A(n-1, n-1) = 72/17;
A(n-1, n) = -28/17;
A(n, n-3) = -12/17;
A(n, n-2) = 96/17;
A(n, n-1) = -156/17;
A(n, n) = 72/17;

b = [];
for i=1:n
    b(i) = -480 * 0.3 * 0.03 * 9.81 * (h^4/(E * I));
end
b = b';

y = A \ b;
y = y';
x = 0.2:h: 2;

y_exact = [];
for i=1:n
    xi = 0.2 * i;
    f =  -480 * 0.3 * 0.03 * 9.81;
    y_exact(i) = (f/(24 * E * I))*xi^2*(xi^2-4*L*xi+6*L^2);
end

% figure
% plot(x, y, x, y_exact)
mat = A;
err = y(n) - y_exact(n);
