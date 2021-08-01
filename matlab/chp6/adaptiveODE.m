% chp 6.5
t = 0:0.5:20;
y = 1 - exp(-10 * t)/2;

% opts0 = odeset('RelTol', 1e-4);
% [t0, y0] = ode45(@stiff, [0, 100], 0.5, opts0);
% plot(t, y, 'r', t0, y0, 'b');
% % plot(t0, y0, 'b');
% axis([0 20 0.9999 1]);

opts1 = odeset('RelTol', 1e-4);
[t1, y1] = ode23s(@stiff, [0, 100], 0.5, opts1);
plot(t, y, 'r', t1, y1, 'b');
% plot(t0, y0, 'b');
axis([0 20 0.9999 1]);