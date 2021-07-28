L = 2;
n = 10;
E = 1.3 * 10 ^ 10;
w = 0.3;
d = 0.03;
g = 9.81;
I = w * d^3/12;
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
    b(i) = -480 * w * d * g * (h^4/(E * I));
end
b = b';

y = A \ b;
y = y';
x = 0.2:h: 2;

b_human = [];
for i=1:n
    if i<=n-1
        b_human(i) = -480 * w * d * g * (h^4/(E * I));
    else
        b_human(i) = -480 * w * d * g * 70 / 0.2 * (h^4/(E * I)); % human standing on position 1.8
    end
end
b_human = b_human';
y_human = A \ b_human;

figure
plot(x, y, x, y_human)
