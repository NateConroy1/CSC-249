%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #4
    houghTransform.m

    The function that performs the Hough Transform. It calculates
    the accumulator array and displays the parameter space image
    using imagesc. It also selects and displays the peaks above
    a certain threshold and draws the lines represented by those
    peaks over the original image, and saves the results.
    ****************************************************************
%}

function accumulatorArray = houghTransform(originalImage)

    height = size(originalImage, 1);
    width = size(originalImage, 2);
    
    offset = height + width + 1;
    
    accumulatorArray = zeros(offset * 2 - 1, 181);
        
    for y = 1:height
        for x = 1:width
            if(originalImage(y,x) > 0)
                for degree = 0:180
                    theta = degree * (pi/180);
                    r = x * cos(theta) + y * sin(theta);
                    z = round(r);
                    accumulatorArray(z + offset, degree + 1) = accumulatorArray(z + offset, degree + 1) + 1; 
                end
            end
        end
    end
    
    fig = figure();
    imagesc(accumulatorArray);
    saveas(fig, 'images/houghTransform_sc.png');
    
    % perform a Gaussian smoothing of the parameter space image
    paramSpace = imread('images/houghTransform_sc.png');
    smoothedImage = imgaussfilt(paramSpace, 1.35);
    imwrite(smoothedImage, 'images/smoothed_image.png');
    
    % VOTE COUNT THRESHOLD IS CURRENTLY SET TO 28, BUT I TESTED AT MULTIPLE
    % VALUES AS EXPLAINED IN REPORT
    
    % calculate peaks
    peaks = zeros(size(accumulatorArray, 1), size(accumulatorArray, 2));
    for i = 1:size(accumulatorArray, 1)
        for j=1:size(accumulatorArray, 2)
            if(accumulatorArray(i,j) >= 28)
                peaks(i,j) = 255;
            end
        end
    end
    
    fig = figure();
    imagesc(peaks);
    saveas(fig, 'images/peaks_threshold_28.png');
     
    
    for i=1:size(accumulatorArray, 1)
        for j = 1:size(accumulatorArray, 2)
            % the following commented line represents the local maxima values used
%             if( i == 111 && j == 139 || i == 146 && j == 45 || i == 65 && j == 176 || i == 165 && j == 45 || i == 115 && j == 1 || i == 124 && j == 1)
            if(accumulatorArray(i,j) >= 28)
                distance = i - offset;
                degree = j - 1;
                theta = degree * (pi / 180);
                for x = 1:width
                    y = (distance - x * cos(theta)) / sin(theta);
                    y = round(y);
                    if(y >= 1 && y <= height)
                        originalImage(y,x) = 120;
                    end
                end
                for y = 1:height
                    x = (distance - y * sin(theta)) / cos(theta);
                    x = round(x);
                    if(x >= 1 && x <= width)
                        originalImage(y,x) = 120;
                    end
                end
            end
        end
    end

    fig = figure();
    imagesc(originalImage);
%     saveas(fig, 'images/local_maxima_selection.png');
    saveas(fig, 'images/edgeDetection_threshold_28.png');
        
end