function x = sor(a, b, w, k)
n = length(b);
D = diag(diag(a));
U = triu(a, 1);
L = tril(a, -1);
% u_dense = full(u)
% l_dense = full(l)
x = zeros(n, 1);
for j=1:k
    bi = b - U * x;
    x = inv(w*L+D) * (w * bi + (1-w) * D * x);
end