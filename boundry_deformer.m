function [S, border, mu] = boundry_deformer(I, k, blur,background, interactive, refresh_rate, fig)

global mu I S N H background

outgif = 'out2.gif';
first_frame = true;

[H,W,D] = size(I);

%% initialization
if blur == true
    I = imgaussfilt(I, 2);
end

S = k*ones([H,W]);  % initial segmentation
for i = 1:k-1
    S(:,floor(W/k)*(i-1)+1:floor(W/k)*i) = i;
end
N = [floor(W/k)*H*ones(k-1,1);(W-floor(W/k)*(k-1))*H];

mu = zeros(k,D); % means
for i = 1:k-1
    mu(i,:) = mean(mean(I(:,floor(W/k)*(i-1)+1:floor(W/k)*i,:)));
end
mu(end,:) = mean(mean(I(:,floor(W/k)*(k-1)+1:end,:)));

%% plotting the original pictures and the initial segments
if interactive
    % colormap = rand(k,3); colormap = (colormap-min(colormap))./range(colormap);
    subplot 132 ;imshow(S,mu/255); drawnow
end

%% deforming the edges
flag1 = true;
iter = 0;
while flag1 == true
    iter = iter + 1;
    flag1 = false;
    %% boundry detector
    bR =  S(:,1:end-1) ~= S(:,2:end);
    bB =  S(1:end-1,:) ~= S(2:end,:);
    bV = [bR,zeros(H,1)] + [zeros(H,1),bR];
    bH = [bB;zeros(1,W)] + [zeros(1,W);bB];
    border = bH + bV > 0;
    borderID = find(border(:))';
    
    for t = borderID
        flag2 = false;
        i = rem(t-1,H) + 1;
        j = floor((t-1)/H) +1;
        St = S(i,j);
        
        %% pixel neighbourhood
        if i == 1
            if j == 1 % top left
                neighbours = [S(i+1,j), S(i+1,j+1),S(i,j+1)] == St; start = 2;
            elseif j == W  % top right
                neighbours = [S(i,j-1), S(i+1,j-1),S(i+1,j)] == St; start = 1;
            else % top
                neighbours = [S(i,j-1), S(i+1,j-1), S(i+1,j), S(i+1,j+1), S(i,j+1)] == St; start = 1;
            end
        elseif i == H
            if j == 1 % bottom left
                neighbours = [S(i,j+1), S(i-1,j+1),S(i-1,j)] == St; start = 3;
            elseif j == W % bottom right
                neighbours = [S(i-1,j), S(i-1,j-1),S(i,j-1)] == St; start = 0;
            else % bottom
                neighbours = [S(i,j+1), S(i-1,j+1), S(i-1,j), S(i-1,j-1), S(i,j-1)] == St; start = 3;
            end
        elseif j == 1 % left
            neighbours = [S(i+1,j), S(i+1,j+1), S(i,j+1), S(i-1,j+1), S(i-1,j)] == St; start = 2;
        elseif j == W % right
            neighbours = [S(i-1,j), S(i-1,j-1), S(i,j-1), S(i+1,j-1), S(i+1,j)] == St; start = 0;
        else % middle
            neighbours = [S(i-1,j), S(i-1,j-1), S(i,j-1), S(i+1,j-1), S(i+1,j),...
                S(i+1,j+1),S(i,j+1),S(i-1,j+1)] == St; start = 0;
        end
        
        %% deciding the flip
        if any(~neighbours(1:2:end))
            [flag2, i_prim, j_prim] = flip_decider(i, j, neighbours, start);
            if flag2
                update_colors(i,j,i_prim,j_prim)
                flag1 = true;
            end
        end
    end
    %% show plot
    if interactive && (mod(iter, refresh_rate) == 0)
        subplot 132; imshow(S,mu/255);
        subplot 133; imshow(~border); drawnow
        
        %% saving the gif
        frame = getframe(fig);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        % Write to the GIF File
        if first_frame
            imwrite(imind,cm,outgif,'gif', 'Loopcount',inf);
            first_frame = false;
        else
            imwrite(imind,cm,outgif,'gif','WriteMode','append');
        end
          
    end
end

