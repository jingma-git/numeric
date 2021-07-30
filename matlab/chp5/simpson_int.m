% Simpson integration
function s = simpson_int(f, a, b, m)
h = 0.5 * (b-a) / m;
s = 0;
x = a;
n =  2 * m;
for i=0: n
    y = f(x);
    if i==0 || i==n
        s = s + y;
    elseif mod(i, 2) == 1
        s = s + 4 * y;
    else
        s = s + 2 * y;
    end
    x = x + h;
end
s = h/3 * s;