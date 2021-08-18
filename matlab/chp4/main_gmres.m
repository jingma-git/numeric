max_iter = 50;
n = 15;
A = diag(sqrt(1:n)) + diag(cos(1:(n-10)), 10) + diag(sin(1:(n-10)), -10);
x_exact = ones(n, 1);
b = A * x_exact;
[x, err] = GMRES(A, b, max_iter);
[x1, err1] = GMRES_pre(A, b, max_iter);
k = length(err);
k1 = length(err1);
plot(1:k, err, 'r', 1:k1, err1, 'b')
% axis([0 k, 0 1])