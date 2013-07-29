function mi = bsp_mi(signal1, signal2)
    mi = 0;
    [join, map, p1, p2] = bsp_joint_pmass(signal1, signal2);
    for i = 1:length(join)
        ind = map(i,:);
        if join(i) ~= 0 && p1(ind(1))*p2(ind(2)) ~= 0
               mi = mi + join(i)*log2(join(i)/(p1(ind(1))*p2(ind(2))));
        end
    end
