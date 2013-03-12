function [band, fm, mode] = signal_band(x,Fs,limiar)
    if nargin == 2
        limiar = 0.6;
    end
    filt = fir1(40,0.1,'high');
    x = filter(filt,1,x);
    L = max(size(x));
    NFFT = 2^nextpow2(L);
    Y = fft(x,NFFT)/L;
    Y = 2*abs(Y(1:NFFT/2));
    f = Fs/2*linspace(0,1,NFFT/2);
    maxs = find(Y >= max(Y));
    mode = f(maxs(1));
    inds = find(Y >= limiar*max(Y));
    lb = f(min(inds));
    ub = f(max(inds));
    band = (ub - lb);
    fm = band/2;
    plot(f,Y);