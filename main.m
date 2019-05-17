
clear all
rng(2);

n = 1000; % Number of data points

% generate data (select one of three below)
[x, y, x_true, y_true, sp] = get_input_data(n, 10, .1, 'simple_sin_struct');
% [x, y, x_true, y_true, sp] = get_input_data(n, 10, .1, 'simple_sin_nstruct');
% [x, y, x_true, y_true, sp] = get_input_data(n, 4, .1, 'complex_sin_struct');

% Run robust TPS algorithm
[inlX, inlY, outX, outY] = get_robust_TPS_fit(x,y, floor(n/2),floor(n/10),floor(n/2),sp);
[parm] = get1DTPS(inlX,inlY,sp);
[Yhat] = getVals1DTPS(x,inlX,parm);
Yhat_MSSE = Yhat';

% Plot results
plot(x,y,'k.'); hold on
plot(inlX,inlY,'ro')
hold on
[xs,I]=sort(x);
plot(xs,Yhat_MSSE(I),'g-','LineWidth',2)
ylim([-5,6])
legend('Input data', 'Identified Inliers', 'TPS-fit', 'Location', 'southeast')
set(gca,'fontsize', 18);
