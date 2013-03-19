function [bel, up, med] = bsp_bandwidth(signal, Fs)

%take at maximum 20000 samples, for performance sake
l = numel(signal);
if l > 20000
    b = floor(l/2) - 10000;
    u = floor(l/2) + 10000;
end
%calculate the power estimate
[Px, x] = pwelch(signal(b:u), 33, 32, [], Fs, 'onesided');
%scale the units for dB
P = 10*log10(Px);
%find the points where the power is 3dB lower than the max
max_power = max(P);
indx = find(P >= max_power - 3);
bel = x(indx(1));
up = x(indx(numel(indx)));
%insert an offset to prevent the area from being negative
mini = min(P);
if mini < 0
    P = P + abs(mini);
end
%calculates the area
area = trapz(P);
tol = area*0.05;
half_area = area/2;
%set the variables for the binary search of the median frequency
upp = numel(x);
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
        upp = idx;
        idx = floor((idx - bot)/2);
        greater = 1;
    end
    if f_area < (half_area + tol)
        if greater == 1
            break;
        end
        bot = idx;
        idx = floor((upp - idx)/2);
    end
    greater = 0;
end
med = f;