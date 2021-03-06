% f = @(x) log(x)
% s0 = trapezoid_int(f, 1, 2, 4)
% s1 = simpson_int(f, 1, 2, 4)

% f = @(x) (1 + sin(exp(3*x)));
% s = adapquad(f, -1, 1, 0.5*10^-4)

% Reality check
epn = 10^-6;
f = @(t) sqrt( (0.3+7.8*t-14.1*t*t)^2 + (0.3+1.8*t-8.1*t*t)^2);
tot_arclen = adapquad(f, 0, 1, epn);

n = 4;
arclen = tot_arclen / 4;
g = @(t) adapquad(f, 0, t, epn)
t = [0];
for i=1:n
    t(i+1) = bisect(g, 0, 1, arclen, epn);
    arclen = arclen + tot_arclen / 4;
end

gx = @(t) 0.5 + 0.3*t + 3.9*t^2 - 4.7*t^3;
gy = @(t) 1.5 + 0.3*t + 0.9*t^2 - 2.7*t^3;
xt = arrayfun(gx, t);
yt = arrayfun(gy, t);

tt = 0:0.01:1;
x = arrayfun(gx, tt);
y = arrayfun(gy, tt);
plot(x, y, 'k', xt, yt, 'o')


