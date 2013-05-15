function H = bsp_spec_en(signal,c,Fs,nfft,p,base)
%% Function name....: bsp_shan_en
% Date.............: May 15, 2013
% Author...........: Nicolai Diniz Linhares 
% Description......:
%                    This function computes the Spectral entropy of a
%                    signal, which is the shannon entropy of the signal
%                    spectral info
% Parameters.......: 
%                    signal .....-> input series
%                    c ..-> positive constant
%                    Fs ..-> sampling frequency
%                    nfft ..-> number of point in the fft(optional)
%                    p ..-> autoregressive model degree(optional)
%                    base(optional) ..-> the log base, default is e
% Return...........:
%                    H .... -> Shannon entropy in the suited base
% Usage............:
%                    t = (0:500)*0.001; 
%                    y1 = sin(2*pi*60*t) + 0.8*sin(2*pi*80*t);
%                    H1 = bsp_ap_en(y1,1);
%                    H2 = bsp_ap_en(y1,0.69,2);

if nargin == 3
    nfft = 1024;
    p = 4;
elseif nargin == 4
    p = 4;
end

[Px, x] = pburg(signal, p, nfft, Fs);

if(nargin < 5)
    H = bsp_shan_en(Px,c);
else
    H = bsp_shan_en(Px,c,base);
end
H = H/log(length(signal));