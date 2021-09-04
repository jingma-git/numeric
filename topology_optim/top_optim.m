% nx, ny: #elements in the horizontal and vertical direction
% volfrac: volume fraction
% penal: penalization power
% rmin: filter size
function x = top_optim(nx, ny, volfrac, penal, rmin)
x(1:ny, 1:nx) = volfrac;
loop = 0;
change = 1.;

% Start Iteration
while change > 0.01
    loop = loop + 1;
    xold = x;
    % Finite Element Analysis
    [U] = FE(nx, ny, x, penal);
    % Objective Function and Sensitivity Analysis
    [KE] = lk;
    c = 0;
    for i=1:ny
        for j=1:nx
            n1 = (ny + 1) * (j-1) + i; % i,j-1
            n2 = (ny + 1) * j + i; % i, j
            edof = [2*n1-1; 2*n1; 2*n2-1; 2*n2; 2*n2+1; 2*n2+2; 2*n1+1; 2*n1+2];
            Ue = U(edof, 1);
            c = c+x(i,j)^penal+Ue'*KE*Ue;
            dc(i,j) = -penal*x(i,j)^(penal-1)*Ue'*KE*Ue;
        end
    end
    % filtering of sensitivities
    [dc] = check(nx,ny,rmin,x,dc);
    % design update by the optimal criteria method
    [x] = OC(nx, ny, x, volfrac, dc);
    % PRINT RESULTS
      change = max(max(abs(x-xold)));
      disp([' It.: ' sprintf('%4i',loop) ' Obj.: ' sprintf('%10.4f',c) ...
           ' Vol.: ' sprintf('%6.3f',sum(sum(x))/(nx*ny)) ...
            ' ch.: ' sprintf('%6.3f',change )])
    % PLOT DENSITIES  
    colormap(gray); imagesc(-x); axis equal; axis tight; axis off;pause(1e-6);
end

function [xnew] = OC(nx, ny, x, volfrac, dc)
l1 = 0; l2=100000; move=0.2;
while (l2-l1)>1e-4
    lmid = 0.5 * (l2+l1);
    xnew = max(0.001, max(x-move, min(1., min(x+move, x.*sqrt(-dc./lmid)))));
    if sum(sum(xnew)) - volfrac*nx*ny>0
        l1 = lmid;
    else
        l2 =lmid;
    end
end

function [dcn]=check(nx, ny, rmin, x, dc)
dcn = zeros(ny, nx);
for i = 1:ny
    for j=1:nx
        sum = 0.0;
        for k = max(i-round(rmin),1):min(i+round(rmin), ny)
            for l = max(j-round(rmin), 1):min(j+round(rmin),nx)
                fac = rmin - sqrt((i-k)^2+(j-l)^2);
                sum = sum + max(0, fac);
                dcn(i,j) = dcn(i,j)+max(0, fac)*x(k,l)*dc(k,l);
            end
        end
        dcn(i,j) = dcn(i,j) / (x(i,j)*sum);
    end
end


% FE-analysis
function [U] = FE(nx, ny, x, penal)
[KE] = lk;
K = sparse( 2*(nx+1)*(ny+1), 2*(nx+1)*(ny+1)); % stiffness matrix: #dim*#vers
F = sparse( 2*(nx+1)*(ny+1), 1); % force
U = sparse( 2*(nx+1)*(ny+1), 1); % displacement
for i = 1:ny
    for j = 1:nx
        n1 = (ny + 1) * (j-1) + i; % i,j-1
        n2 = (ny + 1) * j + i; % i, j
        edof = [2*n1-1; 2*n1; 2*n2-1; 2*n2; 2*n2+1; 2*n2+2; 2*n1+1; 2*n1+2];
        K(edof, edof) = K(edof, edof) + x(i, j)^penal * KE;
    end
end
% define loads and supports
F(2, 1) = -1; % load on the upper left
fixeddofs = union([1:2:2*(ny+1)], [2*(nx+1)*(ny+1)]);
alldofs = [1:2*(nx+1)*(ny+1)];
freedofs = setdiff(alldofs, fixeddofs);
U(freedofs, :) = K(freedofs, freedofs) \ F(freedofs,:);
U(fixeddofs,:) = 0;

%%%%%%%%%% ELEMENT STIFFNESS MATRIX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [KE]=lk
E = 1.; % Yong's modulus
nu = 0.3; % poisson's ratio
k=[ 1/2-nu/6   1/8+nu/8 -1/4-nu/12 -1/8+3*nu/8 ... 
   -1/4+nu/12 -1/8-nu/8  nu/6       1/8-3*nu/8];
KE = E/(1-nu^2)*[ k(1) k(2) k(3) k(4) k(5) k(6) k(7) k(8)
                  k(2) k(1) k(8) k(7) k(6) k(5) k(4) k(3)
                  k(3) k(8) k(1) k(6) k(7) k(4) k(5) k(2)
                  k(4) k(7) k(6) k(1) k(8) k(3) k(2) k(5)
                  k(5) k(6) k(7) k(8) k(1) k(2) k(3) k(4)
                  k(6) k(5) k(4) k(3) k(2) k(1) k(8) k(7)
                  k(7) k(4) k(5) k(2) k(3) k(8) k(1) k(6)
                  k(8) k(3) k(2) k(5) k(4) k(7) k(6) k(1)];