function [THETA_H_L2,KNOT_H_L2] = getFKLOSfit1D(x,vals,k,p,Kth,sp)

% INPUTS:
%   x: input data 
%   vals: input data 
%   k: location around which the next tuple is selected
%   p: polynormial order
%   Kth : Kth residual location
%   sp: lambda for TPS (smoothing parameter)
%
% OUTPUTS:
%   THETA_H_L2: Final estimated parameters
%   KNOT_H_L2: The p data points used in estimation


n = length( vals );
p1 = floor(p/2);
Jmin = 10^7;
imax = 200;
X = x;
Z = vals;
loop1Count = 1;
max_l1Count = 20;
Jmin_H_L2 = 0;


while 1         % while loop 1
    %get an initial Guess
    I = randperm(n);
    I = I(1:p);
    [parm] = get1DTPS(X(I),Z(I),sp);
    [Zhat] = getVals1DTPS(X,X(I), parm);
    
    [r,j] = sort( abs(Z'-Zhat) );

    Jprev = r(Kth)^2;
    MAD = 1.4826*median(abs(r - median(r)));
    Jtreshold = (10^-5)*MAD;
    i=0;
    Jmin = 10^7;
    while 1   % while loop 2
        
        Xp = X(j(k-p1:k+p1));
        Zp = Z(j(k-p1:k+p1));
        
        [parm] = get1DTPS(Xp,Zp,sp);
        [Zhat] = getVals1DTPS(X,Xp, parm);
        
        [r,j] = sort( abs(Z'-Zhat) );
    
        J = r(Kth)^2;
        deltaJ = abs(J - Jprev);
        Jprev = J;
        i = i+1;
        
        if(Jmin > J) 
            Jmin = J;
            THETA = parm ;
            KNOT = Xp;
            %Ret_XYZ_L1 = [Xp;Yp;Zp];
        end
        
        if ( (Jtreshold > deltaJ) || (i > imax) ) % break the while loop 2
            THETA_H_L1 = THETA;
            KNOT_H_L1 = KNOT;
            Jmin_H_L1 = Jmin;
            
            break;
        end
    end   %end loop 2
    
    if( (Jmin_H_L1 <  Jmin_H_L2) || (loop1Count == 1) )
        Jmin_H_L2 = Jmin_H_L1;
        THETA_H_L2 = THETA_H_L1;
        KNOT_H_L2 = KNOT_H_L1;
        %Ret_XYZ_L2 = Ret_XYZ_L1;
    end
    
    loop1Count = loop1Count + 1;   
    if (loop1Count > max_l1Count) % break the while loop 1
        break;
    end
    
end
    