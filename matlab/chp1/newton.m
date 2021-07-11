function sol = newton(f, df, x0, tol)
x = x0;
iter = 0;
while 1
    xi = x;
    x = x - f(x)/ df(x);
%     sprintf("iter%d %12f %12f\n", iter, xi, x)
    a = [xi, x];
    b = [0, f(x)];
    line(a, b, 'Color','red','LineStyle','--');
    iter = iter + 1;
    if abs(x-xi) < tol
        break
    end
    if iter > 100
        break
    end
end
sol = x;