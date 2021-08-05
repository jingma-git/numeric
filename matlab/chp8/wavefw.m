function w=wavefw(xl, xr, yt, yb, M, N)
f = @(x) sin(pi*x);
g = @(t) 0*t;
l = @(t) 0*t;
r = @(t) 0*t;
%c = 2;
c = 6;
h = (xr-xl)/M; k = (yt-yb)/N; m = M - 1; n = N;
sigma = (c * k) / h;
a = diag(2-2*sigma^2*ones(m, 1)) + diag(sigma^2*ones(m-1, 1), 1) + diag(sigma^2*ones(m-1, 1), -1);
lside = l(yb + (0:n)*k); rside = r(yb + (0:n)*k);
w(:,1)=f(xl+(1:m)*h)';
w(:,2)=0.5 * a * w(:,1) + k * g(xl+(1:m)*h)' + 0.5 * sigma^2 * [lside(1); zeros(m-2,1);  rside(1)];
for j=2:n
    w(:,j+1) = a*w(:,j) - w(:, j-1) + sigma^2*[lside(j); zeros(m-2,1);rside(j)];
end

w=[lside;w;rside];
x=(0:m+1)*h; t=(0:n)*k;
mesh(x, t, w')
view(60, 30);
axis([xl xr yb yt -1 2])
