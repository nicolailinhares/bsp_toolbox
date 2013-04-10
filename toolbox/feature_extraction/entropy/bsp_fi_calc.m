%% Function name....: bsp_fi_m
% Date.............: March 14, 2013
% Author...........: Nicolai Diniz Linhares
% Description......:
%                    This function computes the fi parameter for the
%                    entropy calculation
% Parameters.......: 
%                    signal .....-> input series
%                    m ..-> size of the sequency to be compared
%                    r ..-> similarity tolerance (0.1*SD < r < 0.25*SD)
%                    N ..-> number of points of the series to be used
% Return...........:
%                    fi_m .... -> the fi parameter
% Usage............:
%                   it's not to be used, unless by the bsp_ap_en fucntion

function fi_m = bsp_fi_calc(m,r,N,seg)
    for i=1:(N-m+1)
        x(i,:)= seg(i:(i+m-1));
    end

    for i=1:(N-m+1)
        for j=1:(N-m+1)
            sub(j) = max(x(i,:) - x(j,:));
        end
        C(i) = numel(find(sub < r));
    end
    C = C/(N-m+1);
    fi_m = sum(log(C));
    fi_m= fi_m/(N-m+1);