n1 = 7
A = toeplitz([2.5, -1, zeros(1, n1-3), 1]);
b = [1; zeros(n1-1, 1)];
x = A \ b;

% initial value
x0 = zeros(n1, 1); x1 = x0;
r0 = b - A * x0; r1 = r0; p0 = r0; p1 = r0;
k = 1; epn = 1; max_iter = 100; tol = 1e-6; w=0.1;

tic
while k < max_iter && epn > tol
    % cg
    if k <=1
        % select the quickest descending direction, alpha makes sure f(x) reaches mimimum at point x1
        alpha = (p0.' * r0) / (p0' * A * p0); 
        x1 = x0 + alpha * p0;
        r1 = b - A * x1;
    else
        % when reaches x1, instead of select the quickest descending
        % direction, find the direction p1 A_orthogonal to p0 by
        % Gram-Schimit
        beta = (r1' * A * p0) / (p0' * A * p0);
        p1 = r1 - beta * p0;
        alpha = (p1' * r1) / (p1' * A * p1); 
        x1 = x0 + alpha * p1;
        r1 = b - A * x1;
    end
    epn = norm(r1, inf);
    x0 = x1;
    k = k + 1;
    p0 = p1;
    r0 = r1;
end
toc
norm(x-x1, inf)
fprintf('iter stopped at step %d and tol=%8.4e\n', k, tol)

