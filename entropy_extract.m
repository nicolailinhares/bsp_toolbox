function feat = entroy_extract(signal)
    feat = struct();
    feat.specen = wentropy(signal,'log energy');
    feat.shanen = wentropy(signal, 'shannon');
    feat.apen = ApEn(2,0.25*std(signal),10000,signal);

