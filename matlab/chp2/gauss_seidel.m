function x = gauss_seidel(a, b, k)
n = length(b);
d = diag(diag(a));
u = triu(a, 1);
l = tril(a, -1);
% u_dense = full(u)
% l_dense = full(l)
x = zeros(n, 1);
for j=1:k
    bi = b - u * x;
    for i=1:n
        x(i) = (bi(i) - l(i,:)*x) / d(i, i);
    end
end