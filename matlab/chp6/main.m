f = @(t, y) t*y+t^3
F = @(t) 3 * exp(t^2/2)-t^2-2

% % chp6.1
% t = 0:0.2:1;
% y = arrayfun(F, t);
% [t0, y0] = euler(f, [0, 1], 1, 5);
% [t1, y1] = euler(f, [0, 1], 1, 20);
% plot(t,y,'r', t0,y0,'b', t1, y1, 'g')


t = 0:0.1:1;
y = arrayfun(F, t);
[t0, y0] = euler(f, [0, 1], 1, 10);
[t1, y1] = trapezoid(f, [0, 1], 1, 10);
[t2, y2] = rk4(f, [0, 1], 1, 10);
plot(t,y,'r', t0,y0,'b', t1, y1, 'g')
y0-y
y1-y
y2-y