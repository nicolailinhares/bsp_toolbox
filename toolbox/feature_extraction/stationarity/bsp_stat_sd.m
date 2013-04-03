function [me,sd,ds] = bsp_stat_sd(signal, t, Fs)
%% Function name....: bsp_stat_sd
% Date.............: February 20, 2013
% Author...........: Nicolai Diniz Linhares
% Description......:
%                    This function computes the sd of the mean and sd of
%                    the signal and the degree of the stationarity as the
%                    time goes
% Parameters.......: 
%                    signal .....-> input series
%                    t ..-> the period of time of each calculation
%                    Fs ..-> the sampling frequeny of the signal
% Return...........:
%                    me .... -> the standard deviation of the mean
%                    sd .... -> the standard deviation of the standard
%                    deviation
%                    ds ... -> the median of the degrees of stationarity of
%                    each window
% Usage............:
%                    t = (0:500)*0.001; 
%                    y1 = sin(2*pi*60*t);
%                    [me,sd] = bsp_stat_sd(y1, 100);
    n = t*Fs;
    split = bsp_vector_split(signal, n);
    if iscell(split) ~= 1
        throw(MException('InvalidParameter'));
    end
    L = max(size(split));
    s_info = zeros(L,2);
    ds_info = zeros(L,1);
    for i = 1:L
        s_info(i,1) = mean(split{i});
        s_info(i,2) = std(split{i});
        ds_info(i) = bsp_ds(split{i}, Fs);
    end
    s = std(s_info);
    me = s(1);
    sd = s(2);
    ds = median(ds_info);