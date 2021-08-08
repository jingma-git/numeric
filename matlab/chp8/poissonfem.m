function w=poissonfem(xl, xr, yb, yt, M, N)
m = M - 1; n = N - 1;
h = (xr - xl) / m; h2 = h^2;
k = (yt - yb) / n; k2 = k^2;
x = xl + (0:m)*h;
y = yb + (0:n)*k;

A = zeros(M*N, M*N);
b = zeros(M*N, 1);
f=@(x,y) 0;
r=@(x) 0;
% inside
for i=2:m
    for j=2:n
        B1 = [x(i)-2/3*h, y(j)-1/3*k];
        B2 = [x(i)-1/3*h, y(j)-2/3*k];
        B3 = [x(i)+1/3*h, y(j)-1/3*k];
        B4 = [x(i)+2/3*h, y(j)+1/3*k];
        B5 = [x(i)+1/3*h, y(j)+2/3*k];
        B6 = [x(i)-1/3*h, y(j)+1/3*k];
        rsum = r(B1) + r(B2) + r(B3) + r(B4) + r(B5) + r(B6);
           
        p=i+(j-1)*M;
        A(p, p) = 2*(h2+k2)/(h*k) - h*k*rsum/18;
        A(p, p-1) = -k/h - h*k*(r(B6)+r(B1))/18;
        A(p, i-1+(j-2)*M) =  -h*k*(r(B1)+r(B2))/18;
        A(p, i+(j-2)*M) = -h/k - h*k*(r(B2)+r(B3))/18;
        A(p, i+1 + (j-1)*M) =  -k/h - h*k*(r(B3)+r(B4))/18;
        A(p, i+1 + (j)*M) =  -h*k*(r(B4)+r(B5))/18;
        A(p, i+(j)*M) = -h/k - h*k*(r(B5)+r(B6))/18;
        
        
        fsum=f(x(i)-2*h/3,y(j)-k/3)+f(x(i)-h/3,y(j)-2*k/3)...
                +f(x(i)+h/3,y(j)-k/3); 
        fsum=fsum+f(x(i)+2*h/3,y(j)+k/3)+f(x(i)+h/3,y(j)+2*k/3)...
                +f(x(i)-h/3,y(j)+k/3); 
        b(i+(j-1)*m)=-h*k*fsum/6; 
    end
end

% Boundary Value
bottom = @(x) log(x.*x + 1);
top = @(x) log(x.*x + 4);
left = @(y) 2 * log(y);
right = @(y) log(y.*y + 1);
% bottom-top
for i=1:M
    j=1; A(i+(j-1)*M, i+(j-1)*M)=1; b(i+(j-1)*M,1)=bottom(x(i));
    j=N; A(i+(j-1)*M, i+(j-1)*M)=1; b(i+(j-1)*M,1)=top(x(i));
end
% left-side
for j=2:n
    i=1; A(i+(j-1)*M, i+(j-1)*M)=1; b(i+(j-1)*M,1)=left(y(j));
    i=N; A(i+(j-1)*M, i+(j-1)*M)=1; b(i+(j-1)*M,1)=right(y(j));
end

v = A \ b;
w = reshape(v, M, N);
mesh(x, y, w');
view(60, 30);
