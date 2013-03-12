function ds = degree_stationarity(signal)
    L = max(size(signal));
    h_transf = hilbert(signal);
    n = (sum(abs(h_transf)))/L;
    elem = (1 - (abs(h_transf)./n)).^2;
    ds = sum(elem)/L;