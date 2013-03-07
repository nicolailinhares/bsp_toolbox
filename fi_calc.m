function fi_m = fi_calc(m,r,N,seg)
    for i=1:(N-m+1)
        for j=1:m
            x(i,j)= seg( i+j-1 );
        end
    end

    for i=1:(N-m+1)
        C(i)=0;
        for j=1:(N-m+1)
            if ( (max(x(i,:)-x(j,:))) < r )
                C(i)=C(i) + 1;
            end
        end
    end
    C = C/(N-m+1);

    fi_m = 0;
    for i=1:(N-m+1)
        fi_m = fi_m + log(C(i));
    end
    fi_m= fi_m/(N-m+1);