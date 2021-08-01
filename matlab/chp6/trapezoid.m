% inter: time interval
% y0: initial value
% n: number of steps
% trapezoid([0,1], 1, 10)
function [t, y] = trapezoid(f, inter, y0, n)
t(1) = inter(1);
y(1) = y0;
h = (inter(2)-inter(1))/n;
for i=1:n
    t(i+1) = t(i) + h;
    y(i+1) = y(i) + h/2 * (f(t(i), y(i))+f(t(i)+h, y(i)+h));
end
