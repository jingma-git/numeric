function [x, err] = GMRES(A, b, max_iter)
x0 = zeros(length(b), 1);
x = x0;
r = b - A * x0;
q(:,1) = r ./ norm(r);
err = [];
for k=1:max_iter
    y = A * q(:,k);
    for j=1:k
        h(j,k) = q(:,j)' * y;
        y = y - h(j,k) * q(:,j);
    end
    h(k+1, k) = norm(y);
    err(k) = h(k+1, k);
    if h(k+1,k) < 10^-6
        break;
    end
    q(:, k+1) = y ./ h(k+1, k);
    [Q, R]=qr(h); % QRx=b --> Rx=Q'*b (Q is a orthomatrix, so, Q'==inverse(Q))
    bk = zeros(k+1,1);
    bk(1,1) = norm(r);
    ck = R \ (Q' * bk);
    x = q(:,1:k) * ck + x0;
end

