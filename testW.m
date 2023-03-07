clear; close all;

y1  = 0.0;
y2  = 1.0;
ny  = 10;

msh = bofGrid(y1,y2,ny);

par.gam = 0.0009775;
par.omegax = 2*pi;
par.fnth = par.omegax*msh.rm(msh.mp1);
par.fsth = 0.0;

coef = condif(msh, par);
coef = sourw(msh, par, coef);

bp = zeros(msh.mp1,1);
[coef, bp] = implicit_bndr(coef, msh, bp, par);

[A, b] = assembleEquation(msh, coef, bp);

w(2:msh.m) = A\b;

w = bndrSet(par, msh, w);

figure(1)
visualize(w, msh)
hold on

%% Split solution

msh1 = bofGrid(0.0, 0.5 , ny/2);
msh2 = bofGrid(0.5, 1.0 , ny/2);

coef1 = condif(msh1, par);
coef2 = condif(msh2, par);
coef1 = sourw(msh1, par, coef1);
coef2 = sourw(msh2, par, coef2);
bp1 = zeros(msh1.mp1,1);
bp2 = zeros(msh2.mp1,1);
[coef1, bp1] = implicit_bndr(coef1, msh1, bp1, par, true, false);
[coef2, bp2] = implicit_bndr(coef2, msh2, bp2, par, false, true);

% coef1 = rsi_bndr(coef1,msh1,par,true);
% coef2 = rsi_bndr(coef2,msh2,par,false);

[A11, b1] = assembleEquation(msh1, coef1, bp1, true);
[A22, b2] = assembleEquation(msh2, coef2, bp2, false);

A11(end,end)    =  coef1.ap(msh1.mp1);
A11(end,end-1)  = -coef1.as(msh1.mp1);

A22(1,1) =  coef2.ap(1);
A22(1,2) = -coef2.an(1);

c1 = zeros(msh1.mp1,1);
c2 = zeros(msh2.mp1,1);

c1(msh1.m)   = 0.5;
c1(msh1.mp1) = 0.5;
c2(1)   = -0.5;
c2(2)   = -0.5;

lagrMult = 0.0;
rsiPen = 1e3;

A = [A11 zeros(size(A11)); zeros(size(A11)) A22];

C = [c1(2:msh1.mp1); c2(1:msh2.m)];

G = rsiPen*(C * C');

b = [b1; b2];

maxIter = 100;
for iter = 1:maxIter

    w = (A + G)\(b - lagrMult*C);
    
    violation = C'*w;
    
    lagrMult = lagrMult + rsiPen*violation;

    fprintf('Iter: %5d Violation: %12.5e\n', [iter, abs(violation)])

    if abs(violation) < 1e-15
        break
    end

end

w1 = [2.0*par.fsth - w(1); w(1:end/2)];
w2 = [w(end/2+1:end); 2.0*par.fnth-w(end-1)];
w1p = 0.5*(w1(1:end-1) + w1(2:end));
w2p = 0.5*(w2(1:end-1) + w2(2:end));

figure(1)
plot(msh1.rm(2:end-1),w1p,'r') 
hold on
plot(msh2.rm(2:end-1),w2p,'b')

figure()
plot(w)









