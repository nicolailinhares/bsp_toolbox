function fi_m = fi_calc(m,r,N,seg)
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