% instead of solve for a single equation but solve for a system of ODEs
F1 = @(t) t*exp(-2*t);
F2 = @(t) exp(-t);

t = 0:0.1:1;
y(1, :) = arrayfun(F1, t);
y(2, :) = arrayfun(F2, t);
[t0, y0] = euler_sys([0 1], [0, 1], 10)
plot(t, y0(:, 1), 'bo', t, y(1, :), 'b', t, y0(:, 2), 'go', t, y(2,:), 'g')