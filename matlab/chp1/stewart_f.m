function out = stewart_f(theta)
% L1 = 2;
% L2 = sqrt(2);
% L3 = sqrt(2);
% gamma = pi/2;
% p1 = sqrt(5);
% p2 = sqrt(5);
% p3 = sqrt(5);
% x1 = 4;
% x2 = 0;
% y2 = 4;
L1 = 3;
L2 = sqrt(3);
L3 = 3;
gamma = pi/4;
p1 = 5;
p2 = 5;
p3 = 3;
x1 = 5;
x2 = 0;
y2 = 6;


A2 = L3 * cos(theta) - x1;
B2 = L3 * sin(theta);
A3 = L2 * cos(theta + gamma) - x2;
B3 = L2 * sin(theta + gamma) - y2;
D = 2 * (A2*B3-A3*B2);
N1 = B3 * (p2^2 - p1^2 - A2^2 - B2^2) - B2 * (p3^2-p1^2-A3^2-B3^2);
N2 = -A3*(p2^2 - p1^2 - A2^2 - B2^2) + A2 * (p3^2-p1^2-A3^2-B3^2);

x = N1 / D;
y = N2 / D;
out = N1^2 + N2^2 - p1^2 * D^2;