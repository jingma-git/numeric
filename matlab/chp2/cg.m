function [x, err] =  cg(A, b, max_iter)
x = zeros(length(b), 1);
d = b - A * x;
r = d;
err = [];
for k=1:max_iter
    err(k) = max(abs(r));
    if err(k) < eps
        break
    end
    alpha = r' * r / (d' * A * d);
    x = x + alpha * d;
    r_update = r - alpha * A * d;
    beta = r_update' * r_update / (r' * r);
    d = r_update + beta * d;
    r = r_update;
end

