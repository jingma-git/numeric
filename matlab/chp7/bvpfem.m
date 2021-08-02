function c=bvpfem(inter, bv, n)
a=inter(1); b=inter(2);
ya=bv(1); yb=bv(2);
h=(b-a)/(n+1);
alpha=(8/3)*h+2/h;
beta=(2/3)*h-1/h;
e=ones(n,1);
M=spdiags([beta*e alpha*e beta*e], -1:1, n, n);
b=zeros(n,1);
b(1)=-ya*beta;
b(n)=-yb*beta;
c=M\b;