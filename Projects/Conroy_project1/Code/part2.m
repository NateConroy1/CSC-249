%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Project #1, Image Filtering
    part2.m

    Filtering an image in the space domain
    ****************************************************************
%}

function x = part2(originalImage)

% Gaussian low pass filter
kernel = fspecial('gaussian', [3 3], 3);
result = filter2(kernel, originalImage);

fig = figure;
imshow(result, []);
saveas(fig, 'images/gaussian_lp.jpg');

fig = figure;
freqz2(kernel);
saveas(fig, 'images/freqResponse_lp.jpg');

% perform the Gaussian low pass as independent 1-D calculations to
% demonstrate that it is separable filter
kernel = fspecial('gaussian', [3 1], 3);
kernel2 = fspecial('gaussian', [1 3], 3);
resultA = filter2(kernel, originalImage);
resultB = filter2(kernel2, resultA);

fig = figure;
imshow(resultB, []);
saveas(fig, 'images/gaussian_lp_separable.jpg');

% high pass filter
[imageHP,filter] = highPassFilter(originalImage);

fig = figure;
imshow(imageHP, []);
saveas(fig, 'images/gaussian_hp.jpg');

fig = figure;
freqz2(filter);
saveas(fig, 'images/freqResponse_hp.jpg');

% median pass filter
imageMF = medfilt2(originalImage, [3 3]);

fig = figure;
imshow(imageMF);
saveas(fig, 'images/medfilt.jpg');

% sobel edge detector
sobel = fspecial('Sobel');

result = uint8(filter2(sobel, originalImage));

fig = figure;
imshow(result, []);
saveas(fig, 'images/sobelFilter.jpg');

fig = figure;
freqz2(sobel);
saveas(fig, 'images/freqResponse_sobel.jpg');

%----------------------------
% Add noise to image, repeat
%----------------------------

noiseImage = imnoise(originalImage, 'gaussian');
fig = figure;
imshow(noiseImage);
saveas(fig, 'images/image_noise.jpg');

% Gaussian low pass filter
kernel = fspecial('gaussian', [3 3], 3);
result = filter2(kernel, noiseImage);

fig = figure;
imshow(result, []);
saveas(fig, 'images/gaussian_lp_noise.jpg');

% high pass filter
imageHP = highPassFilter(noiseImage);

fig = figure;
imshow(imageHP, []);
saveas(fig, 'images/gaussian_hp_noise.jpg');

% median pass filter
imageMF = medfilt2(noiseImage, [3 3]);

fig = figure;
imshow(imageMF);
saveas(fig, 'images/medfilt_noise.jpg');

% sobel edge detector
sobel = fspecial('Sobel');

result = uint8(filter2(sobel, noiseImage));

fig = figure;
imshow(result, []);
saveas(fig, 'images/sobelFilter_noise.jpg');

%------------------------------------
% Add impulse noise to image, repeat
%------------------------------------

noiseImage = imnoise(originalImage, 'salt & pepper');
fig = figure;
imshow(noiseImage);
saveas(fig, 'images/image_impulseNoise.jpg');

% Gaussian low pass filter
kernel = fspecial('gaussian', [3 3], 3);
result = filter2(kernel, noiseImage);

fig = figure;
imshow(result, []);
saveas(fig, 'images/gaussian_lp_impulseNoise.jpg');

% high pass filter
imageHP = highPassFilter(noiseImage);

fig = figure;
imshow(imageHP, []);
saveas(fig, 'images/gaussian_hp_impulseNoise.jpg');

% median pass filter
imageMF = medfilt2(noiseImage, [3 3]);

fig = figure;
imshow(imageMF);
saveas(fig, 'images/medfilt_impulseNoise.jpg');

% sobel edge detector
sobel = fspecial('Sobel');

result = uint8(filter2(sobel, noiseImage));

fig = figure;
imshow(result, []);
saveas(fig, 'images/sobelFilter_impulseNoise.jpg');

end