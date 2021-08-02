a=0; b=1;
ya=1; yb=3;
n=9;
c=bvpfem([a b], [ya yb], n);
plot([a a+(1:n)*(b-a)/(n+1) b], [ya; c; yb]);
