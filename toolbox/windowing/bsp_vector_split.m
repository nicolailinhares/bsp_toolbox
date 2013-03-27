function split = bsp_vector_split(signal,n)
%% Function name....: bsp_zc
% Date.............: February 20, 2013
% Author...........: Nicolai Diniz Linhares
% Description......:
%                    This function split the signal into windows containing
%                    n points
% Parameters.......: 
%                    signal .....-> input series
%                    n ..-> number of values in each window
% Return...........:
%                    split .... -> a cell array containing as many vectors
%                    as necessary to put the signal into the specified
%                    window
% Usage............:
%                    t = (0:500)*0.001; 
%                    y1 = sin(2*pi*60*t);
%                    z1 = split(y1,100);

    L = max(size(signal));
    pages = idivide(int32(L), int32(n),'floor');
    rest = rem(L,n);
    split = {};
    for i = 1:pages
        bel = n*(i-1)+1;
        %split(i,1:n) = signal(bel:(bel+n-1));
        split{i} = signal(bel:(bel+n-1));
    end
    if rest > 0
        bel = pages*n + 1;
        %split(i+1,1:rest) = signal(bel:(bel+rest-1));
        split{i+1} = signal(bel:(bel+rest-1));
    end
    