%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #4
    extractBoundaryPoints.m

    This function takes in a binary image (background is one value
    and foreground is another), and returns a copy of the image in
    which only the pixels representing the boundaries of components
    are extracted from the original image. These boundary pixels are
    defined as any foreground pixel that has a background pixel
    within it's 8-connected neighborhood.
    ****************************************************************
%}

function image = extractBoundaryPoints(originalImage)

    height = size(originalImage, 1);
    width = size(originalImage, 2);

    image = zeros(width, height);
    
    for i=1:height
        for j= 1:width
            if(originalImage(i,j) > 0)
                if(i ~= 1 && j ~= 1 && originalImage(i-1,j-1) == 0)
                   image(i,j) = 255;
                   
                elseif(i ~= 1 && originalImage(i-1,j) == 0)
                   image(i,j) = 255;
                   
                elseif(i ~= 1 && j ~= width && originalImage(i-1,j+1) == 0)
                    image(i,j) = 255;
                                       
                elseif(j ~= 1 && originalImage(i,j-1) == 0)
                   image(i,j) = 255;
                   
                elseif(j ~= width && originalImage(i,j+1) == 0)
                    image(i,j) = 255;
                    
                elseif(i ~= height && j ~= 1 && originalImage(i+1,j-1) == 0)
                    image(i,j) = 255;
                    
                elseif(i ~= height && originalImage(i+1,j) == 0)
                    image(i,j) = 255;
                    
                elseif(i ~= height && j~= width && originalImage(i+1,j+1) == 0)
                    image(i,j) = 255;
                   
                end
            end
        end
    end
end