x = [0 1 2 3 4 5];
y = [3 1 4 1 2 0];
n = length(x);
k = 100;
[b, c, d] = splinecoeff(x, y);

x1 = [];
y1 = [];
for i=1:n-1
    xs = linspace(x(i), x(i+1), k+1);
    dx = xs - x(i);
    % nested multiplication
    ys = d(i) * dx;
    ys = (ys + c(i)) .* dx;
    ys = (ys + b(i)) .* dx + y(i);
    x1 = [x1; xs(1:k)'];
    y1 = [y1; ys(1:k)'];
end

plot(x, y, 'o', x1, y1)