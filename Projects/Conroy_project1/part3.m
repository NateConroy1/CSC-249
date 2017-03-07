%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Project #1, Image Filtering
    part3.m

    The 2-D Fourier Transform
    ****************************************************************
%}

function x = part3(originalImage)

fft = fft2(originalImage);

% undedited FFT
fig = figure;
ffta = abs(fft);
imagesc(ffta);
colormap(gray);
saveas(fig, 'images/fft.jpg');

% shifted FFT
fig = figure;
fftb = fftshift(ffta);
imagesc(fftb);
colormap(gray);
saveas(fig, 'images/fftshift.jpg');

% FFT with log
fig = figure;
fftc = log(fft) + 10;
fftc = abs(fftc);
imagesc(fftc);
colormap(gray);
saveas(fig, 'images/fft_log.jpg');

% shifted FFT with log
fig = figure;
fftd = fftshift(fftc);
imagesc(fftd);
colormap(gray);
saveas(fig, 'images/fftshift_log.jpg');

% shifted FFT with log of darker image
image2 = imread('images/phase2_grayscale.jpg');
fft = fft2(image2);
fig = figure;
fft = abs(fft);
fft = log(fft) + 10;
fft = fftshift(fft);
imagesc(fft);
colormap(gray);
saveas(fig, 'images/fftshift_log2.jpg');

end