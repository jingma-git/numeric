% Trapezoid integration
function s = trapezoid_int(f, a, b, m)
h = (b-a) / m;
s = 0;
x = a;
for i=0:m
    y = f(x);
    if i==0 || i==m
        s = s + y;
    else
        s = s + 2 * y;
    end
    x = x + h;
end
s = h * 0.5 * s;