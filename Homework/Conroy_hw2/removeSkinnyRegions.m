%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #2
    removeSkinnyRegions.m

    This method removes components of an image with aspect ratios
    greater than 3:1.
    ****************************************************************
%}

function originalImage = removeSkinnyRegions(originalImage);

colors = [];

for i = 1:size(originalImage,1)
    for j = 1:size(originalImage,2)
        if(originalImage(i,j) ~= 0)
            colors = union(colors, originalImage(i,j));
        end
    end
end

% array of bad component label numbers
toRemove = [];

for i = 1:size(colors,2)
    bb = getBoundingBox(originalImage, colors(i));
    width = bb(2) - bb(1) + 1;
    height = bb(4) - bb(3) + 1;   
    if(width > height * 3)
        toRemove = union(toRemove, colors(i));
    end
end

% remove the selected regions
for n = 1:size(toRemove, 2)
    component = toRemove(n);
    for i = 1:size(originalImage,1)
        for j = 1:size(originalImage,2)
            if(originalImage(i,j) == component)
                originalImage(i,j) = 0;
            end
        end
    end
end

% create figure
skinnyAreasRemoved = imagesc(originalImage);

% make labels consecutive numbers
originalImage = makeLabelsConsecutive(originalImage);

% set figure text
originalImage = setFigureText(originalImage);

% save figure with skinny components removed
saveas(skinnyAreasRemoved,'remove_regions2.png');

end