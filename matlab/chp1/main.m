% eg 1.15
% f = @(x) 4*x^4-6*x^2-11/4;
% df = @(x) 16*x^3-12*x;
% 
% x = -2: 0.1: 2;
% y = arrayfun(f, x);
% plot(x, y)
% v = [-3, 3, -6, 2]
% axis(v)
% 
% sol = newton(f, df, 0.5, 10^-4)

% f = @(x) x^3 + x -1
% fzero(f, [0, 1], optimset('Display', 'iter'))

% activity
% x = -2* pi: 0.001 : 2 * pi;
% y = arrayfun(@stewart, x);
% plot(x, y)

theta = fzero(@stewart_f, [-pi/4, pi/4]);
stewart(theta)