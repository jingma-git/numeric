function y = sin1(x)
b = pi * (0:3)/ 6;
yb = sin(b);
c = newtdd(b, yb, 4);

n = length(x);
x1 = [];
s = [];
for i=1:n
    s(i) = 1;
    x1(i) = mod(x(i), 2*pi);
    if x1(i)>pi
        x1(i) = 2 * pi - x(i);
        s(i) = -1;
    end

    if x1(i) > pi/2
        x1(i) = pi - x1(i);
    end
end
y = s .* nest(3, c, x1, b);