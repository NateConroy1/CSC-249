%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #2
    getBinMap.m

    This method iterates through all pixels in a grayscale image,
    and sets all pixels with a value over the threshold to 255, and
    and all pixels under the threshold to 0.
    ****************************************************************
%}

function originalImage = getBinMap(originalImage)

for i = 1:size(originalImage,1)
    for j = 1:size(originalImage,2)
        % set pixel threshold to 60
        if(originalImage(i,j) > 60)
            originalImage(i,j) = 255;
        else
            originalImage(i,j) = 0;
        end
    end
end

imwrite(originalImage,'binary_map.png');

end
