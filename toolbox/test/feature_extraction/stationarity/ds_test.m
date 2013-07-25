Fs = 1000;
T = 1/Fs;
L = 3000;
t = (0:L-1)*T;  
y1 = sin(2*pi*400*t);
y2 = exp(-t).*sin(2*pi*200*t);
y3 = (t/2 + 0.5).*sin(2*pi*100*t);
y4 = sin((1/4)*pi*(t.^2));

dss = [bsp_ds(y1,Fs); bsp_ds(y2,Fs); bsp_ds(y3,Fs); bsp_ds(y4,Fs); bsp_ds(y1+y2+y3+y4,Fs)];

