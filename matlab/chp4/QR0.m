function [Q, R] = QR0(A)
[m, n] = size(A);

Q = zeros(m, n);
R = zeros(n, n);
for j=1:n
    y = A(:,j);
    for i=1:j-1
        R(i,j) = Q(:,i)' * A(:,j);
        y = y - Q(:,i) * R(i,j);
    end
    R(j, j) = norm(y);
    Q(:, j)=y ./ R(j, j);
end