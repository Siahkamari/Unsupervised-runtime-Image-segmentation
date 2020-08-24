%% flip decider
function [flag, i_prim, j_prim] = flip_decider(i,j,neighbours, start) % S(i,j) <- S(i_prim,j_prim)
global mu I S H background
i_prim = nan; j_prim = nan;
ij_rgb = squeeze(I(i,j,:))';
perimeter  = length(neighbours);

%% checking conectivity of the region after changing the (i,j) segment assignment
if all(~neighbours) || S(i,j) == background % special case for background and for singualr pixel
    flag = true;
else
    t1 = find(neighbours,1,'first');
    t2 = find(neighbours,1,'last');
    flag = sum(neighbours(t1:t2)) == t2 - t1 + 1; % if true the regions will stay connected
    if (perimeter == 8) && (~flag)
        t1 = find(~neighbours,1,'first');
        t2 = find(~neighbours,1,'last');
        flag = sum(~neighbours(t1:t2)) == t2 - t1 + 1; % if true the regions will stay connected
    end
end
% flag = true; % no connectivity check

% checking whether the pixel is better of with what segment
if flag
    candidates = rem(find(~neighbours(1:2:perimeter)) + start - 1,4) +1;
    TLBR = [-1,0;0,-1;1,0;0,1] + [i,j];
    delta = metric(ij_rgb - mu(S(sum((TLBR(candidates,:) - [0,1]).*[1,H],2)),:));
    [min_val,argmin] = min(delta);
    if all(~neighbours) || (min_val < metric(ij_rgb - mu(S(i,j),:)))             % if pixel is singualr it will change it no matter what
        i_prim = TLBR(candidates(argmin), 1);
        j_prim = TLBR(candidates(argmin), 2);
    else
        flag = false;
    end
end
end