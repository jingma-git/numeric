function [x, err] =  cg_pre(A, b, max_iter)
M = diag(A);
x = zeros(length(b), 1);
r = b - A * x;
z = r./ M;
d = z;
err = [];
for k=1:max_iter
    err(k) = max(abs(r));
    if err(k) < eps
        break
    end
    alpha =  r' * z / (d' * A * d);
    x = x + alpha * d;
    r_update = r - alpha * A * d;
    z_update = r_update ./ M;
    beta = r_update' * z_update / (r' * z);
    d = z_update + beta * d;
    r = r_update;
    z = z_update;
end