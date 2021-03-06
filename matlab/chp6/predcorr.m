% chp6.7 implicit multistep
% Adams Bashforth Multon
% inter: interval
% y0: initial value
% s: multi-steps
function [t,y] = predcorr(inter, y0, n, s)
h=(inter(2)-inter(1))/n;
t(1)=inter(1);
y(1, :)=y0;

for i=1:s-1
    t(i+1) = t(i) + h;
    y(i+1, :) = trapstep(t(i), y(i,:), h); % second step
    z(i,:)=f(t(i), y(i,:)); % first step
end

for i=s:n
    t(i+1)=t(i)+h;
    z(i,:)=f(t(i), y(i,:));
    y(i+1,:)=ab2step(t(i),i,y,z,h); % prediction
    z(i+1,:)=f(t(i+1), y(i+1,:));
    y(i+1,:)=am1step(t(i),i,y,z,h);
end

% adams bashforth
function z = ab2step(t,i,y,f,h)
z = y(i,:)+ h*(3/2*f(i,:) - f(i-1,:)/2);

% adams multion
function z = am1step(t,i,y,f,h)
z = y(i,:)+h/2*(f(i+1,:)+f(i,:));

function z=trapstep(t, y, h)
z1=f(t,y);
z2=f(t+h, y+h*z1);
z=y+h/2*(z1+z2);


function z=f(t,y)
z=t*y+t^3;