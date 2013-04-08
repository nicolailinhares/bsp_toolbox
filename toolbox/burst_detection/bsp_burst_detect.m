function [inds, rsignal] = bsp_burst_detect(signal,thres,smoothness)
    if nargin < 2
        thres = 0.1;
    elseif thres < 0 || thres > 1
        throw(MException('InvalidParameter'));
    end
    if nargin < 3;
        smoothness = 5;
    end
    signal = signal - mean(signal);
    env = abs(hilbert(signal));
    env = smooth(env,'lowess',smoothness);
    maxi = max(signal);
    inds_noise = find(env < thres*maxi);
    inds = find(env >= thres*maxi);
    rsignal = env;
    rsignal(inds_noise) = 0;
    if nargout == 0
        plot(signal);
        hold on;
        plot(env,'g');
        plot(rsignal,'r');
    end