function x = broyden1(f, x0, max_iter)
[n, m] = size(x0);
x = x0;
B = eye(n, n);
for i=1:max_iter
    x_old = x
    x = x - B * f(x);
    d = x - x_old;
    D = f(x) - f(x_old);
    B = B + (d - B * D) * d' * B / (d' * B * D);
end

% % Program 2.3 Broyden's Method II
% % Input: x0 initial vector, k = max steps
% % Output: solution x
% % Example usage: broyden2(f,[1;2],10)
% function x=broyden2(f,x0,k)
% [n,m]=size(x0);
% b=eye(n,n);           % initial b
% for i=1:k
%   x=x0-b*f(x0);
%   del=x-x0;delta=f(x)-f(x0);
%   b=b+(del-b*delta)*del'*b/(del'*b*delta);
%   x0=x;
% end

