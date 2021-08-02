% eg.7.6
s0=-1; s1=0;
F(s0)
F(s1)
s = fzero(@F, [s0, s1])
[t,y]=ode45(@ydot, [0,1], [1, s]);
plot(t,y(:, 1));

% % eg.7.7 % does not know why this does not work
% s0=0; s1=2;
% F(s0)
% F(s1)
% s = fzero(@F, [s0, s1])
% [t,y]=ode45(@ydot, [1, 2], [0, s]);
% plot(t,y);
