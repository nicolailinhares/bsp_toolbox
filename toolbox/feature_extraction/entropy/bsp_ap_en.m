function ap_en = bsp_ap_en(signal,m,r,N)
%% Function name....: bsp_ap_en
% Date.............: March 14, 2013
% Author...........: Nicolai Diniz Linhares
% Description......:
%                    This function computes the aproximated entropy of a
%                    signal
% Parameters.......: 
%                    signal .....-> input series
%                    m ..-> size of the sequency to be compared
%                    r ..-> similarity tolerance (0.1*SD < r < 0.25*SD)
%                    N ..-> number of points of the series to be used
% Return...........:
%                    ap_en .... -> aproximated entropy estimation
% Usage............:
%                    t = (0:500)*0.001; 
%                    y1 = sin(2*pi*60*t) + 0.8*sin(2*pi*80*t);
%                    y2 = sin(2*pi*120*t) + 0.7*sin(2*pi*140*t);
%                    ap_en = bsp_ap_en(y1,2,0.15*std(y1),250);
%                    ap_en = bsp_ap_en(y2,2,0.15*std(y2),250);

if (length(signal) < N)
    disp('the number points to be used is greater than the signal length')
    N = length(signal);
end
u = signal(1:N);

fi_m = bsp_fi_calc(m,r,N,u);
fi_m2 = bsp_fi_calc(m+1,r,N,u);

ap_en = fi_m - fi_m2;