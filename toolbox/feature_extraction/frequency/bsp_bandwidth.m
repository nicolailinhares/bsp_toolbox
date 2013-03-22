function [fl, fh, med] = bsp_bandwidth(signal, Fs, nfft, p)
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
if nargin == 2
    nfft = 1024;
    p = 4;
elseif nargin == 3
    p = 4;
end
%calculate the power estimate
[Px, x] = pburg(signal, p, nfft, Fs);
%use spline interpolation fucntion for better resolution
new_x = 0:0.1:x(end);
P = spline(x,Px,new_x);
max_power = max(P);
%find the points where the power is 3dB lower than the max
indx = find(P >= 0.707*max_power);
fl = new_x(indx(1));
ind_fl = indx(1);
fh = new_x(indx(numel(indx)));
ind_fh = indx(numel(indx));
if nargout ~= 2
    %calculates the area
    area = trapz(P);
    tol = area*0.005;
    half_area = area/2;
    %set the variables for the binary search of the median frequency
    fhp = numel(new_x);
    half_point = floor(numel(new_x)/2);
    idx = half_point;
    bot = 0;
    greater = 0;
    %execute the loop until the calculate area lays inside the tolerate interval
    %for the half of the area
    for i = 1:half_point
        f = new_x(idx);
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
        h = plot(new_x,P);
        line(fl,P(ind_fl),'Marker','s','Color','red','LineWidth',2.0);
        line(fh,P(ind_fh),'Marker','s','Color','red','LineWidth',2.0);
        line([med,med],[0, max_power],'Color','magenta');
    end
end
