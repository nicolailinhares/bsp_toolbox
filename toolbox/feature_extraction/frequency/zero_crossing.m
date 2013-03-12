function zero_count = zero_crossing(seq, limiar)
%% Function name....: zero_crossing
% Date.............: February 20, 2013
% Author...........: Nicolai Diniz Linhares
% Description......:
%                    This function counts how many time a signal pass
%                    through zero
% Parameters.......: 
%                    seq .....-> input series
%                    limiar ..-> the threshold to be consider as zero
% Return...........:
%                    zero_count .... -> the number of identified zero
%                    crossings
% Usage............:
%                    t = (0:500)*0.001; 
%                    y1 = sin(2*pi*60*t);
%                    y2 = sin(2*pi*120*t) + 0.5;
%                    z1 = zero_crossing(y1);
%                    z2 = zero_crossing(y2, 0.5);

                    
    [l,c] = size(seq);
    if nargin == 1
        limiar = 0;
    end
    seq = seq - limiar;
    zero_count = 0;
    for i = 2:c
        abs_a = abs(seq(i-1));
        abs_b = abs(seq(i));
        abs_mi_a = abs(abs_a - abs_b);
        abs_mi_b = abs(seq(i-1) - seq(i));
        abs_pl_a = abs_a + abs_b;
        abs_pl_b = abs(seq(i-1) + seq(i));
        if abs_mi_a < abs_mi_b || abs_pl_a > abs_pl_b
          zero_count = zero_count + 1;
        end
    end