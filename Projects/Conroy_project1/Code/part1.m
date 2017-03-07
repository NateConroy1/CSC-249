%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Project #1, Image Filtering
    part1.m

    Read, write, and display an image using Matlab commands
    ****************************************************************
%}

function originalImage = part1()

originalImage = imread('images/phase1_grayscale.jpg');

% display image with imshow
fig = figure;
imshow(originalImage);
saveas(fig, 'images/phase1_imshow.jpg');

% display image with imagesc
fig2 = figure;
imagesc(originalImage);
saveas(fig2, 'images/phase1_imagesc.jpg');

% display colormap
cmap = colormap(fig);
fig3 = figure('Position', [100, 100, 1049, 895]);
surf(cmap);
colormap default;
colorbar;
saveas(fig3, 'images/colormap.jpg');

end