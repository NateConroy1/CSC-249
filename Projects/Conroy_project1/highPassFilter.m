%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Project #1, Image Filtering
    gaussianHP.m

    Function for performing a high pass FIR filter on an image
    ****************************************************************
%}

function [imageHP, kernel] = highPassFilter(originalImage)

dimension = 3;

% create high pass filter kernel
kernel = [-1, -1, -1; -1, 8, -1; -1, -1, -1];

% create empty matrix with original image's dimensions
imageHP = zeros(size(originalImage,1),size(originalImage,2));

% apply filter using zero padding
for i=1:size(imageHP, 1)
    for j=1:size(imageHP, 2)
        neighbors = zeros(dimension,dimension);
        sum = 0;
        % if not in top left corner
        if(i ~= 1 && j ~= 1)
            sum = sum + double(originalImage(i-1,j-1)) * kernel(1,1);
        end
        %if not in top right corner
        if(i ~= 1 && j ~= size(originalImage, 2))
            sum = sum + double(originalImage(i-1,j+1)) * kernel(1,3);
        end
        % if not in bottom left corner
        if(i ~= size(originalImage, 1) && j ~= 1)
            sum = sum + double(originalImage(i+1,j-1)) * kernel(3,1);
        end
        % if not in bottom right corner
        if(i ~= size(originalImage, 1) && j ~= size(originalImage, 2))
            sum = sum + double(originalImage(i+1,j+1)) * kernel(3,3);
        end
        % if not in top row
        if(i ~= 1)
            sum = sum + double(originalImage(i-1, j)) * kernel(1,2);
        end
        % if not in last row
        if(i ~= size(originalImage,1))
            sum = sum + double(originalImage(i+1, j)) * kernel(3,2);
        end
        % if not in first column
        if(j ~= 1)
            sum = sum + double(originalImage(i,j-1)) * kernel(2,1);
        end
        % if not in last column
        if( j ~= size(originalImage, 2))
            sum = sum + double(originalImage(i,j+1)) * kernel(2,3);            
        end
        sum = sum + double(originalImage(i,j)) * kernel(2,2);
        imageHP(i,j) = sum;
    end
end

imageHP = imageHP;

end