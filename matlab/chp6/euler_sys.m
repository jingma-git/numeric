% inter: time interval
% y0: initial value
% n: number of steps
% euler([0,1], 1, 10)
function [t, y] = euler_sys(inter, y0, n)
t(1) = inter(1);
y(1, :) = y0;
h = (inter(2)-inter(1))/n;
for i=1:n
    t(i+1) = t(i) + h;
    y(i+1, :) = y(i, :) + h * f(t(i), y(i, :));
end


function z = f(t, y)
z(1) = y(2)^2 - 2*y(1);
z(2) = y(1)-y(2)-t*y(2)^2;