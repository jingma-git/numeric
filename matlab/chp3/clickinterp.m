function clickinterp
xl = -3;
xr = 3;
yb = -3;
yt = 3;
plot([xl xr], [0 0], 'k', [0 0], [yb yt], 'k');
grid on;

k = 0;
while 1
    [xnew, ynew] = ginput(1);
    if length(xnew) < 1
        break
    end
    
    k = k + 1;
    xlist(k) = xnew;
    ylist(k) = ynew;
    c = newtdd(xlist, ylist, k);
    x = xl:.01:xr;
    y = nest(k-1, c, x, xlist);
    plot(xlist, ylist, 'o', x, y, 'k');
    axis([xl xr yb yt]);
    grid on;
end