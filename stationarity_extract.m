function feat = stationarity_extract(signal,n)
    feat = struct();
    [feat.cm,feat.sdc] = mean_deviation(signal_split(signal,n));
    feat.ds = degree_stationarity(signal);