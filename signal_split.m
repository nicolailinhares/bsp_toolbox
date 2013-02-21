function split = signal_split(signal,n)
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
    