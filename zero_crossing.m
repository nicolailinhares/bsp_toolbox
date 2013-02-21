function y = zero_crossing(seq, limiar)
    [l,c] = size(seq);
    if nargin == 1
        limiar = 0;
    end
    seq = seq - limiar;
    y = 0;
    for i = 2:c
        abs_a = abs(seq(i-1));
        abs_b = abs(seq(i));
        abs_mi_a = abs(abs_a - abs_b);
        abs_mi_b = abs(seq(i-1) - seq(i));
        abs_pl_a = abs_a + abs_b;
        abs_pl_b = abs(seq(i-1) + seq(i));
        if abs_mi_a < abs_mi_b || abs_pl_a > abs_pl_b
          y = y + 1;
        end
    end