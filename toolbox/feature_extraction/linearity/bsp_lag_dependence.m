function ldf = bsp_lag_dependence(signal,k)
%% Function name....: bsp_ap_en
% Date.............: June 23, 2013
% Author...........: Nicolai Diniz Linhares
% Description......:
%                    This function computes estimate of the lag dependence
%                    used in linearity analysis
% Parameters.......: 
%                    signal .....-> input series
%                    k ..-> the lag to be considered
%                   
% Return...........:
%                    ldf .... -> aproximated entropy estimation
% Usage............:
%                    t = (0:500)*0.001; 
%                    y1 = sin(2*pi*60*t) + 0.8*sin(2*pi*80*t);
%                    y2 = sin(2*pi*120*t) + 0.7*sin(2*pi*140*t);
%                    ap_en = bsp_ap_en(y1,2,0.15*std(y1));
%                    ap_en = bsp_ap_en(y2,2,0.15*std(y2),2);

    yt = signal(k+1:length(signal));
    ytk = signal(1:length(signal)-k);
    coef = polyfit(ytk,yt,1);
    yres = polyval(coef,ytk);
    ssk = sum((yt-yres).^2);
    ss0 = sum((yt - mean(yt)).^2);
    r2 = (ss0 - ssk)/ss0;
    [maxi ind_max] = max(yt);
    [mini ind_min] = min(yt);
    ldf = sign(yres(ind_max) - yres(ind_min))*sqrt(r2);