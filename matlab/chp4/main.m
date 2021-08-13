% % eg 4.1
% A = [1 -1; 1 1; 1 -1];
% b = [2; 1; 3];

% eg 4.2
A = [1 -4; 2 3; 2 2];
b = [-3; 15; 9];

% % eg 4.5: the solution is expected to be [1 1 1 1 1 1 1 1];
% x = (2 + (0:10)*0.2)';
% A = [x.^0 x x.^2 x.^3 x.^4 x.^5 x.^6 x.^7];
% b = 1 + x + x.^2 + x.^3 + x.^4 + x.^5 + x.^6 + x.^7;

% Normal equation
% miminize (Ax - b) means (Ax-b)ortho_to(A)
% A'Ax = A'b
sol = (A'* A) \ (A' * b);
c = cond(A' * A);

% % QR
% % [Q0, R0] = QR0(A);
% [q, r]=qr(A); % QRx=b --> Rx=Q'*b (Q is a orthomatrix, so, Q'==inverse(Q))
% sol_qr = r \ (q' * b);

% Householder
[q, r] = householderQR(A);
A_approx = q * r;
