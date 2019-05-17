function [Zhat] = getVals1DTPS(x,kn,parm)

n = length(x);
k = length(kn);



X = repmat(x',1,k);

X_k = repmat(kn,n,1);

r2 = (X-X_k).^2;
r2I = (r2 == 0);
r2(r2I) = 1;

G = (1/(16*pi)) * r2 .* log(r2);     %TPS
P = [ones(n,1) x'];

D =  [(G), P];

Zhat = (D*parm);