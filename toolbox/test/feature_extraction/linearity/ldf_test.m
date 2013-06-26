x = -2*pi:0.04:2*pi;
y1 = 2.34.*x - 2.56;
y2 = x.*x + 3.56;
y3 = sin(x);
y4 = randn(1,length(y3));

ldfs = [bsp_lag_dependence(y1,4) bsp_lag_dependence(y2,4) bsp_lag_dependence(y3,4) bsp_lag_dependence(y4,4)];

plot(ldfs,'*');