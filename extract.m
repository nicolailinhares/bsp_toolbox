function feat = extract(signal,Fs,n)
    feat = struct();
    feat.frequency = frequency_extract(signal,Fs);
    feat.stationarity = stationarity_extract(signal,n);
    feat.variability = variability_extract(signal);