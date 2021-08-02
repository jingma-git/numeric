% [t0, y0]=exmultistep([0 1], 1, 20, 2);
% plot(t0, y0);


[t0, y0]=predcorr([0 1], 1, 20, 2);
plot(t0, y0);