function [me,sd] = mean_deviation(split)
    if iscell(split) ~= 1
        throw(MException('InvalidParameter'));
    end
    L = max(size(split));
    s_info = zeros(L,2);
    for i = 1:L
        s_info(i,1) = mean(split{i});
        s_info(i,2) = std(split{i});
    end
    s = std(s_info);
    me = s(1);
    sd = s(2);