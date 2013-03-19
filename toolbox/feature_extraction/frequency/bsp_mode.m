function mode = bsp_mode(signal,nbins)

if nargin < 2
    nbins = 30;
end

[n, xout] = hist(signal,nbins);
max_ind = find(n == max(n),1);
mode = xout(max_ind);