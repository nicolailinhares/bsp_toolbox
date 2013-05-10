function limites = bsp_burst_detect(signal,noiseInterval,smoothness)
    if nargin < 3;
        smoothness = 5;
    end
    filt_signal = bsp_ss_filt_emd(signal,noiseInterval(1), noiseInterval(2), 1);
    min_v = min(filt_signal);
    max_v = max(filt_signal);
    neg = find(signal < 0);
    filt_signal(neg) = filt_signal(neg)*(-1);
    env = filt_signal;
    env = smooth(env,'lowess');
    limiar1 = max(env)*0.05;
    limiar2 = max(env)*0.12;
    g = 1;
    fechou = true;
    burst = false;
    for i = 1:length(env)
        if(fechou && env(i) > limiar1)
          temp = i;
          fechou = false;
        elseif(~burst && ~fechou && env(i) > limiar2)
          limites(g) = temp;
          g = g + 1;
          burst = true;
        elseif(~fechou && env(i) < limiar1)
          if(burst)
            limites(g) = i;
            g = g + 1;
          end
          burst = false;
          fechou = true;
        end
    end
    
    if nargout == 0
        plot(env);
        hold on;
        plot(linspace(limiar1,limiar1,length(env)),'g');
        plot(linspace(limiar2,limiar2,length(env)),'r');
        for i = 1:2:length(limites)
            line([limites(i);limites(i)],[min_v; max_v],'Color','magenta');
            line([limites(i+1);limites(i+1)],[min_v; max_v],'Color','green');
        end
    end
    end