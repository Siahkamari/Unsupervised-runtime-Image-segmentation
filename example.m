clear, close all; clc

%% settings
k = 3; % number of segments
background = 1; % <=k
blur = true;
interactive = true;

%% data reading
data_path = 'BSDS500/images/train/';

fig = figure('units','normalized','outerposition',[0 0 1 1]);

I = double(imread(strcat(data_path, '35070.jpg')));


%% running
subplot 131; imshow(I/255);
[S,border, mu] = boundry_deformer(I, k, blur,background, interactive, 10, fig);

subplot 132; imshow(S,mu/255);
subplot 133; imshow(~border); drawnow

