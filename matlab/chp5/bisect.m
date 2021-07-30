% calculate the x0 coordinate that is the intersecion between f(x) and y=y0
function x0=bisect(f, a0, b0, y0, tol)
a=a0; b=b0;
ya=f(a)-y0; yb=f(b)-y0; 
while 1
    c = (a+b)/2;
    yc = f(c) - y0;
    if abs(yc)<tol
        x0=c;
        break
    end
    
    if ya * yc < 0
        b = c;
    else
        a = c;
    end
end