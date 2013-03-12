%%%%%%%%%faz o c�lculo da entropia aproximada de uma s�rie temporal

%%% m = tamanho da sequ�ncia a ser comparada ( geralmente = 2)
%%% r = toler�ncia de semelh�n�a (0.1*SD< r < 0.25*SD)
%%% N = numero de pontos do sinal a ser analisado ( 75 < N < 5000)
function entropia_aproximada = ApEn(m,r,N,sinal)
    
if (length(sinal) < N)
    disp('o tamanho do vetor � menor do que o sinal')
    N = length(sinal);
end
u = sinal(1:N);

fi_m = fi_calc(m,r,N,u);
fi_m2 = fi_calc(m+1,r,N,u);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%calculo da entropia aproximada
entropia_aproximada = fi_m - fi_m2;