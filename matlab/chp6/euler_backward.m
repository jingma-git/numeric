% chp6.6 computer problem 1
function [t,y] = euler_backward(inter, y0, n)
h=(inter(2)-inter(1))/n;
t(1)=inter(1);
y(1)=y0;

for k=1:n
    t(k+1) = t(k)+h;
    y(k+1)=newton(y(k),h,10^-6);
end


function z=f(t,y)
z=y^2-y^3;

function z=newton(wi, h, tol)
z = wi;
while 1
    zold = z;
    z = z - (h*z^3-h*z^2+z-wi) / (3*h*z^2-2*h*z+1);
    if z-zold < tol
        break;
    end
end