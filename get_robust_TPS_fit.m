function [inlXY, inVal,outXY, outVal] = get_robust_TPS_fit(x,vals, k, p,Kth,sp)

% INPUTS:
%   x: input data 
%   vals: input data 
%   k: location around which the next tuple is selected
%   p: minimal subset - related to polynormial order
%   Kth : Kth residual location
%   sp: lambda for TPS (smoothing parameter)
%
% OUTPUTS:
%   inlXY: inliers x
%   inVal: inliers y
%   outXY: outliers x
%   outVal: outliers y


T2 = 2.0^2;
X = x(1,:);
Z = vals;
n = length(vals);
max_iter = 10;
dN = floor(n/20); %5 percent of data

%FKLOS Loop Implementation
hold_Kth = 0;
for loop_count=1:max_iter
    
    [THETA,KNOT] = getFKLOSfit1D(x,Z,k,p,Kth,sp);
    
    [Zhat] = getVals1DTPS(X,KNOT,THETA);
    [r,I] = sort( abs(Zhat-Z') );
    
    hold_i = Kth;
    
    %calculate inliers based on MSSE
    erSum = sum(r(1:Kth));
    sd = erSum/( Kth - 2 );

    for i = ( Kth+1 ):n

        if(r(i) > T2*sd  )
            hold_i = i-1;
            break;
        end
        erSum = erSum + r(i);
        sd =  erSum / (i-2);

    end
    
    p = floor(hold_i/5);
    k = floor(hold_i/2);
    Kth = hold_i-1;
    
    disp(['Loop No: ', num2str(loop_count), ', inlier change: ',num2str(abs(hold_Kth-Kth))])
    
    if loop_count < 4
        hold_Kth = Kth;
    elseif abs(hold_Kth-Kth) < dN
        break;
    else
        hold_Kth = Kth;
    end
    
end

%Final inliers
inlXY = X(I(1:hold_i)) ;
inVal = Z(I(1:hold_i));

outXY =  X(I(hold_i+1:end)) ;
outVal = Z(I(hold_i+1:end));