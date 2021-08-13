function [Q, R] = householderQR(A)
[m, n] = size(A);

Q = eye(m, m);
R = A;
for j=1:n
    x = R(j:m, j);
    w = zeros(m-j+1,1);
    w(1, 1) = norm(x);
    v = w - x;
    H = eye(m-j+1) - 2 * (v * v')/(v'*v);
    R(j:m, j:n) = H * R(j:m, j:n);
    Q(:, j:m) = Q(:,j:m) * H;
end