function feat = variability_extract(signal)
    feat = struct();
    feat.range = range(signal);
    feat.sirange = iqr(signal)/2;
    feat.var = var(signal);
    feat.sd = std(signal);