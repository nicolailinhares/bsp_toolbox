%%%%%%%%%faz o cálculo da entropia aproximada de uma série temporal

%%% m = tamanho da sequência a ser comparada ( geralmente = 2)
%%% r = tolerância de semelhânça (0.1*SD< r < 0.25*SD)
%%% N = numero de pontos do sinal a ser analisado ( 75 < N < 5000)
function entropia_aproximada = ApEn(m,r,N,sinal)
    
if (length(sinal) < N)
    disp('o tamanho do vetor é menor do que o sinal')
    N = length(sinal);
end
u = sinal(1:N);

fi_m = fi_calc(m,r,N,u);
fi_m2 = fi_calc(m+1,r,N,u);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%calculo da entropia aproximada
entropia_aproximada = fi_m - fi_m2;