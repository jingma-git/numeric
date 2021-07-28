n = 100;
eps = 10^-5;
k = 10; % iteration number
[a, b] = sparsesetup(n);
% exact_x = ones(n, 1);
% forward_err = max(abs(x - exact_x))

while 1
 %x = jacobi(a, b, k);
 x = gauss_seidel(a, b, k);
 %x = sor(a, b, 1.2, k);
 err = norm(x-1, inf);
 if err < eps
     break;
 end
 fprintf('%f iter_num=%d\n', err, k);
 k = k + 1;
end
