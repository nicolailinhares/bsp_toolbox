function ds = bsp_ds(signal)
%% Function name....: bsp_ds
% Date.............: February 20, 2013
% Author...........: Nicolai Diniz Linhares
% Description......:
%                    This function estimates the degree of stationarity of
%                    the signal, based on hilbert transformation
% Parameters.......: 
%                    sginal .....-> input series
% Return...........:
%                    ds .... -> the degree of stationarity
% Usage............:
%                    t = (0:500)*0.001; 
%                    y1 = sin(2*pi*60*t);
%                    y2 = sin(2*pi*120*t);
%                    z1 = bsp_ds(y1);
%                    z2 = bsp_ds(y2);
    L = max(size(signal));
    h_transf = hilbert(signal);
    n = (sum(abs(h_transf)))/L;
    elem = (1 - (abs(h_transf)./n)).^2;
    ds = sum(elem)/L;