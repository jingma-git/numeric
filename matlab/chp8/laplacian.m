function w=laplacian(xl, xr, yb, yt, M, N)
m = M - 1; n = N - 1;
h = (xr - xl) / m; h2 = h^2;
k = (yt - yb) / n; k2 = k^2;
x = xl + (0:m)*h;
y = yb + (0:n)*k;

A = zeros(M*N, M*N);
b = zeros(M*N, 1);
% inside
for i=2:m
    for j=2:n
        p=i+(j-1)*M;
        A(p, p) = -2 * (1/h2 + 1/k2);
        A(p, p+1) = 1/h2;
        A(p, p-1) = 1/h2;
        A(p, i + j*M) = 1/k2;
        A(p, i + (j-2)*M) = 1/k2;
    end
end

% Boundary Value
bottom = @(x) log(x.*x + 1);
top = @(x) log(x.*x + 4);
left = @(y) 2 * log(y);
right = @(y) log(y.*y + 1);
% bottom-top
for i=1:M
    j=1; A(i+(j-1)*M, i+(j-1)*M)=1; b(i+(j-1)*M,1)=bottom(x(i));
    j=N; A(i+(j-1)*M, i+(j-1)*M)=1; b(i+(j-1)*M,1)=top(x(i));
end
% left-side
for j=2:n
    i=1; A(i+(j-1)*M, i+(j-1)*M)=1; b(i+(j-1)*M,1)=left(y(j));
    i=N; A(i+(j-1)*M, i+(j-1)*M)=1; b(i+(j-1)*M,1)=right(y(j));
end

v = A \ b;
w = reshape(v, M, N);
mesh(x, y, w');
view(60, 30);
