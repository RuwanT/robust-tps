function [x, y, x_true, y_true, sp] = get_input_data(n, x_range, inlNoice, data_type)

% INPUTS:
%   n: Number of datapoints to generate 1000
%   x_range: range in x dim [-x_range/2,x_range/2] 10
%   inlNoise: inlier noise .1
%   outP: outlier persentage .3
%   data_type:


% OUTPUTS:
%   x: 
%   y: 
%   x_true: uncorrupted_data (ground truth)
%   y_true: uncorrupted_data (ground truth)
%   sp: TPS smoothness parameter

if strcmp(data_type, 'simple_sin_struct')
    x = x_range*(rand(1,n)-0.5);
    x_true = x;
    y = sin(2*x);
    y_true= y;
    y = y + inlNoice*randn(1,n);

    %add outliers different structure
    outP = 0.3;
    outN = floor(n*outP);
    I = randperm(n);
    I = I(1:outN);
    y(I) = 5.0 + .1*(rand(1,length(I))-.5);
    sp = 0.001;
    
elseif strcmp(data_type, 'simple_sin_nstruct') 
    x = x_range*(rand(1,n)-0.5);
    x_true = x;
    y = sin(2*x);
    y_true= y;
    y = y + inlNoice*randn(1,n);
    
    % Add Outliers No Structure
    outP1 = 0.3;
    outN = floor(n*outP1);
    I = randperm(n);
    I = I(1:outN);
    y(I) = 5*randn(1,length(I));
    sp = 0.001;
    
elseif strcmp(data_type, 'complex_sin_struct') 

    x = x_range*(rand(1,n)-0.5);
    x_true = x;
    y = sin(pi*(1-x).^2);
    y_true= y;
    y = y + inlNoice*randn(1,n);
    
    % Add several Structured Outliers
    outP = 0.1;
    outN = floor(n*outP);
    I = randperm(n);
    I = I(1:outN);
    y(I) = 5 + .1*(rand(1,length(I))-.5);
    x(I) = 0 + (5*outP)*(rand(1,length(I))-0.5);

    outP = 0.1;
    outN = floor(n*outP);
    I = randperm(n);
    I = I(1:outN);
    y(I) = 4 + .1*(rand(1,length(I))-.5);
    x(I) = (5*outP) + (5*outP)*(rand(1,length(I))-0.5);

    outP1 = 0.1;
    outN = floor(n*outP1);
    I = randperm(n);
    I = I(1:outN);
    y(I) = 4 + .1*(rand(1,length(I))-.5);
    x(I) = -(5*outP) + (5*outP)*(rand(1,length(I))-0.5);

    sp = .000001;
    
end