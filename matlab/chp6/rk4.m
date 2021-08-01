% inter: time interval
% y0: initial value
% n: number of steps
function [t, y] = rk4(f, inter, y0, n)
t(1) = inter(1);
y(1) = y0;
h = (inter(2)-inter(1))/n;
for i=1:n
    t(i+1) = t(i) + h;
    s1 = f(t(i), y(i));
    s2 = f(t(i)+h/2, y(i)+h/2*s1);
    s3 = f(t(i)+h/2, y(i)+h/2*s2);
    s4 = f(t(i)+h, y(i)+h*s3);
    y(i+1) = y(i) + h/6 * (s1+2*s2+2*s3+s4);
end
