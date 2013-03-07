function soma = b_estimation(x, signal)
    l = max(size(signal));
    b = [0.001];
    h = 1000;
    soma = 0;
    for i = 1:l
        valor = 0;
        for j = 1:max(size(b))
            valor = valor + b(j)*(i-x)^j;
        end
        soma = soma + ((signal(i) - valor)^2)*k_h(0,1,(i-x),h);
    end

end