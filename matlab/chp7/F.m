%chp7.1 eg7.6
function z=F(s)
a=0; b=1; yb=3;
[t,y]=ode45(@ydot, [a,b], [1,s]);
z=y(end, 1)-yb;
 
% function z=F(s)
% a=1; b=2; yb=0;
% [t,y]=ode45(@ydot, [a,b], [0,s]);
% z=y(end, 1)-yb;
