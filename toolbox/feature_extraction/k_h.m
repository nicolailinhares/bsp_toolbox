function y = k_h(m,s,x,h)
    a = 1/sqrt(s*2*pi);
    y = (a*exp(-(x/h-m)/(2*s^2)))/h;