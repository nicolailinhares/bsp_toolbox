function [probxy, map,probx,proby] = bsp_joint_pmass(x,y)

unqx = unique(x);
unqy = unique(y);
%freqxy = zeros(length(unqx), length(unqy));
probx = zeros(1,length(unqx));
proby = zeros(1,length(unqy));
cont = 1;
map = [0 0];
for i = 1:length(x)
    indx = find(unqx == x(i),1);
    indy = find(unqy == y(i),1);
    tx = find(map(:,1) == indx);
    ty = find(map(:,2) == indy);
    inte = intersect(tx,ty);
    if ~isempty(tx) && ~isempty(ty) && ~isempty(inte)
        ind = inte(length(inte));
        freqxy(ind) = freqxy(ind) + 1;
    else
        freqxy(cont) = 1;
        map(cont,:) = [indx indy];
        cont = cont + 1;
    end
    probx(indx) = probx(indx) + 1;
    proby(indy) = proby(indy) + 1;
end

probx = probx/length(x);
proby = proby/length(y);
probxy = freqxy/length(x);