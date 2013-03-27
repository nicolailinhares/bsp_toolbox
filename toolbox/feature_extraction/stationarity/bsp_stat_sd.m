function [me,sd] = bsp_stat_sd(signal, n)
%% Function name....: bsp_zc
% Date.............: February 20, 2013
% Author...........: Nicolai Diniz Linhares
% Description......:
%                    This function calculates the standard deviation of the
%                    mean and the standard deviation of the signal as the
%                    times pass
% Parameters.......: 
%                    signal .....-> input series
%                    n ..-> quantity of points in each window
% Return...........:
%                    me .... -> the standard deviation of the mean
%                    sd .... -> the standard deviation of the standard
%                    deviation
% Usage............:
%                    t = (0:500)*0.001; 
%                    y1 = sin(2*pi*60*t);
%                    [me,sd] = bsp_stat_sd(y1, 100);
    split = bsp_vector_split(signal, n);
    if iscell(split) ~= 1
        throw(MException('InvalidParameter'));
    end
    L = max(size(split));
    s_info = zeros(L,2);
    for i = 1:L
        s_info(i,1) = mean(split{i});
        s_info(i,2) = std(split{i});
    end
    s = std(s_info);
    me = s(1);
    sd = s(2);