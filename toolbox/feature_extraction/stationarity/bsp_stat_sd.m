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
    LSI = numel(signal);
    if n < 1 || n > LSI
        throw(MException('InvalidParameter'));
    end     
    split = bsp_vector_split(signal, n);
    if iscell(split) ~= 1
        throw(MException('InvalidParameter'));
    end
    L = max(size(split));
    s_info = zeros(L,2);
    for i = 1:L
        s_info(i,1) = mean(split{i});
        s_info(i,2) = std(split{i});
        if i ~= L
            [ds_info(i,:),f] = bsp_ds(split{i}, Fs);
        end
    end
    if nargout == 0
        subplot(2,1,1);
        plot(0:1/Fs:(LSI-1)*(1/Fs),signal);
        hold on;
        min_s = min(signal);
        max_s = max(signal);
        xes = zeros(1,L);
        for i = 1:L
            x_pos = i*n*(1/Fs);
            line([x_pos,x_pos],[min_s, max_s],'Color','magenta');
            xes(i) = ((i-1)*n + n/2)*1/Fs;
        end
        plot(xes,s_info(:,1),'ro');
        plot(xes,s_info(:,2),'greeno');
        subplot(2,1,2);
        plot(f,median(ds_info));
    else
    s = std(s_info);
    me = s(1);
    sd = s(2);
    ds = median(ds_info);
    end