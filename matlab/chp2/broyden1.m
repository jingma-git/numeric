function x = broyden1(f, x0, max_iter)
[n, m] = size(x0);
x = x0;
A = eye(n, n);
for i=1:max_iter
    x_old = x
    x = x - A' * f(x);
    d = x - x_old;
    D = f(x) - f(x_old);
    A = A + (D - A * d) * d' / (d' * d);
end