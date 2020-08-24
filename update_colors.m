%% online mean
function update_colors(i,j,i_prim,j_prim) % S(i,j) <- S(i_prim,j_prim)
global mu I S N
S1 = S(i,j);
S2 = S(i_prim,j_prim);
ij_rgb = squeeze(I(i,j,:))';

mu(S2,:) = N(S2)/(N(S2)+1)* mu(S2,:) + ij_rgb/(N(S2)+1);
mu(S1,:) = N(S1)/(N(S1)-1)* mu(S1,:) - ij_rgb/(N(S1)-1);
N(S2) = N(S2) +1; N(S1) = N(S1) - 1;
S(i,j) = S(i_prim,j_prim);
end