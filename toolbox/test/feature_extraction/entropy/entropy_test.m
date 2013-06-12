values = [];
values(1,1:500) = ones(1,500)*3;
t = 0:0.002:(1-0.002);
values(2,1:500) = sin(60*2*pi*t);
values(4,1:500) = randn(1,500);
values(3,1:500) = values(2,:) + values(4,:);
entropy = zeros(4,5);
dim = 2;
for i = 1:4
    r = 0.45*(std(values(i,:)));
    entropy(i,1) = bsp_shan_en(values(i,:),1);
    entropy(i,2) = bsp_spec_en(values(i,:),1,500);
    entropy(i,3) = bsp_ap_en(values(i,:),dim,r);
    entropy(i,4) = bsp_sam_en(values(i,:),dim,r);
    entropy(i,5) = bsp_fuz_en(values(i,:),dim,r);
end

plot(entropy);
legend('shannon','spectral','approximate','sample','fuzzy');