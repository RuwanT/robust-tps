function [parm] = get1DTPS(x,y,p)

n = length(x);
k = length(x);
m =2;

X = repmat(x',1,k);

X_k = repmat(x,n,1);

r2 = (X-X_k).^2;
r2I = (r2 == 0);
r2(r2I) = 1;

G = (1/(16*pi)) * r2 .* log(r2);     %TPS
P = [ones(n,1) x'];

D = [(G + p*n*eye(n)), P; P' zeros(m)];
y = [y';zeros(m,1)];
parm = D\y;


