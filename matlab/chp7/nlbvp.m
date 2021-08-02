%chp7.2 non-linear boundary value problem
function w=nlbvp(inter,bv,n)
a=inter(1); b=inter(2);ya=bv(1); yb=bv(2);
h=(b-a)/(n+1);
w=zeros(n, 1);
for i=1:20
    w=w-jac(w,inter,bv,n)\f(w,inter,bv,n);
end
plot([a a+(1:n)*h b], [ya w' yb]);


function y=f(w,inter,bv,n)
y = zeros(n,1); h=(inter(2)-inter(1))/(n+1);
ya=bv(1); yb=bv(2);
y(1)=ya -(2+h^2)*w(1) + h^2*w(1)^2 + w(2);
y(n)=w(n-1) - (2+h^2)*w(n) + h^2*w(n)^2 + yb;
for i=2:n-1
    y(i)=w(i-1) - (2+h^2)*w(i) + h^2*w(i)^2 + w(i+1);
end

function M=jac(w,inter,bv,n)
h=(inter(2)-inter(1))/(n+1);
M=zeros(n,n);
for i=1:n
    M(i,i)=2*h^2*w(i)-(2+h^2);
end
for i=1:n-1
    M(i,i+1)=1;
    M(i+1, i)=1;
end

