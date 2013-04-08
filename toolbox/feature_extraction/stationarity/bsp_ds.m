function [ds, f] = bsp_ds(signal, Fs)
%% Function name....: bsp_ds
% Date.............: February 20, 2013
% Author...........: Nicolai Diniz Linhares
% Description......:
%                    This function calculates the degree of stationarity
%                    for a period T
% Parameters.......: 
%                    signal .....-> input series
%                    Fs ..-> sampling frequency
%                    p(optional) ..-> the autoregressive order for energy estimation
%                    nfft(optional) ..-> number of points of fft for energy estmation
% Return...........:
%                    ds .... -> the median of the results for each
%                    frequency
% Usage............:
%                    t = (0:500)*0.001; 
%                    y1 = sin(2*pi*60*t);
%                    ds = bsp_ds(y1,1000,0.5);
[H, f, t] = spectrogram(signal, [], [], [], Fs);
H = abs(H);
h = sum(H,2);
T = numel(signal)*(1/Fs);
for k = 1:numel(t)
    H(:,k) = H(:,k)./(h/T);
end
H = ((1 - H).^2)/T;
ds = sum(H,2)';
