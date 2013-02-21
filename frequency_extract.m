function feat = frequency_extract(sinal,Fs)
    feat = struct();
    feat.zc = zero_crossing(sinal);
    [feat.bandwidth,feat.central_frequency,feat.mode] = signal_band(sinal,Fs);
