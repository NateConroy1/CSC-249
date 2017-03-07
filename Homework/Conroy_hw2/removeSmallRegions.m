%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #2
    removeSmallRegions.m

    This method removes components of an image with areas less than
    10 pixels.
    ****************************************************************
%}

function originalImage = removeSmallRegions(originalImage)

% compute component areas, store in hash table
componentAreas = java.util.Hashtable;

for i = 1:size(originalImage,1)
    for j = 1:size(originalImage,2)
        if(originalImage(i,j) ~= 0)
            if(size(componentAreas) < originalImage(i,j))
                componentAreas.put(originalImage(i,j), 1);
            else
                componentAreas.put(originalImage(i,j), componentAreas.get(originalImage(i,j)) + 1);
            end
        end
    end
end

% remove components with areas smaller than 10 pixels
for i = 1:size(originalImage,1)
    for j = 1:size(originalImage,2)
        if(originalImage(i,j) ~= 0)
            if(componentAreas.get(originalImage(i,j)) < 10)
                originalImage(i,j) = 0;
            end
        end
    end
end

% create figure
smallAreasRemoved = imagesc(originalImage);

% make labels consecutive numbers
originalImage = makeLabelsConsecutive(originalImage);

% set figure text
originalImage = setFigureText(originalImage);

% save figure with areas smaller than 10 pixels removed
saveas(smallAreasRemoved,'remove_regions1.png');

end