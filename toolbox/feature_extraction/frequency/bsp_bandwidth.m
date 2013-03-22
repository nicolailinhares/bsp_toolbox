function [fl, fh, med] = bsp_bandwidth(signal, Fs)
%% Function name....: bsp_bandwidth
% Date.............: February 20, 2013
% Author...........: Nicolai Diniz Linhares
% Description......:
%                    This function computes the mode of the signal through
%                    histogram estimation
% Parameters.......: 
%                    signal .....-> input series
%                    Fs ..-> sampling frequency
% Return...........:
%                    bel .... -> frequency of the begining of the band
%                    up .... -> frequency of the end of the band
%                    med ...-> the median frequency
% Usage............:
%                    t = (0:500)*0.001; 
%                    y1 = sin(2*pi*60*t) + 0.8*sin(2*pi*80*t);
%                    y2 = sin(2*pi*120*t) + 0.7*sin(2*pi*140*t);
%                    [fl,fh,med] = bsp_bandwidth(y1,1000);
%                    [fl2,fh2,med2] = bsp_bandwidth(y2,1000);
%take at maximum 20000 samples, for performance sake
l = numel(signal);
if l > 20000
    b = floor(l/2) - 10000;
    u = floor(l/2) + 10000;
    signal = signal(b:u);
end
%calculate the power estimate
[Px, x] = pwelch(signal, [], [], [], Fs, 'onesided');
%scale the units for dB
P = 10*log10(Px);
%find the points where the power is 3dB lower than the max
max_power = max(P);
indx = find(P >= max_power - 3);
fl = x(indx(1));
ind_fl = indx(1);
fh = x(indx(numel(indx)));
ind_fh = indx(numel(indx));
if nargout ~= 2
    %insert an offset to prevent the area from being negative
    mini = min(P);
    if mini < 0
        P = P + abs(mini);
    end
    %calculates the area
    area = trapz(P);
    tol = area*0.005;
    half_area = area/2;
    %set the variables for the binary search of the median frequency
    fhp = numel(x);
    half_point = floor(numel(x)/2);
    idx = half_point;
    bot = 0;
    greater = 0;
    %execute the loop until the calculate area lays inside the tolerate interval
    %for the half of the area
    for i = 1:half_point
        f = x(idx);
        f_area = trapz(P(1:idx));
        if f_area > (half_area - tol)
            fhp = idx;
            idx = idx - floor((idx - bot)/2);
            greater = 1;
        end
        if f_area < (half_area + tol)
            if greater == 1
                break;
            end
            bot = idx;
            idx = idx + floor((fhp - idx)/2);
        end
        greater = 0;
    end
    med = f;
    if nargout == 0
        P = P - abs(mini);
        h = plot(x,P);
        line(fl,P(ind_fl),'Marker','s','Color','red','LineWidth',2.0);
        line(fh,P(ind_fh),'Marker','s','Color','red','LineWidth',2.0);
        line([med,med],[mini, max_power],'Color','magenta');
    end
end
