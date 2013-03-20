function mode = bsp_mode(signal,nbins)
%% Function name....: bsp_mode
% Date.............: February 20, 2013
% Author...........: Nicolai Diniz Linhares
% Description......:
%                    This function computes the mode of the signal through
%                    histogram estimation
% Parameters.......: 
%                    signal .....-> input series
%                    nbins ..-> the amount of intervals for the histogram
%                    estimation
% Return...........:
%                    mode .... -> the computed mode
% Usage............:
%                    t = (0:500)*0.001; 
%                    y1 = 2*sin(2*pi*60*t);
%                    y2 = 3*sin(2*pi*120*t);
%                    z1 = bsp_mode(y1);
%                    z2 = bsp_mode(y2, 50);
if nargin < 2
    nbins = 30;
end

[n, xout] = hist(signal,nbins);
max_ind = find(n == max(n),1);
mode = xout(max_ind);