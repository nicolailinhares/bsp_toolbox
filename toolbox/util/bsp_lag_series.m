function deslocado = bsp_lag_series(serie, lag)
    alag = abs(lag);
    deslocado = serie;
    if lag > 0
        deslocado = serie(alag + 1:length(serie));
        deslocado(length(deslocado) + 1:length(deslocado) + alag) = serie(1:alag);
    else
        deslocado(alag + 1:length(deslocado)) = serie(1:length(serie)-alag);
        deslocado(1:alag) = serie(length(serie)-alag + 1:length(serie));
    end