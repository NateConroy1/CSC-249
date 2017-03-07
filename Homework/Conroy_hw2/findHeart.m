%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #2
    findHeart.m

    EXTRA CREDIT: This method searches the components of an image
    and checks the following 3 conditions:

        (1) The lowest point (biggest y coordinate) is within 10%
            of the middle x coordinate of the component
        (2) The shape has "humps" (the top row of pixels in the
            component are not continuous)
        (3) The shape is relatively as tall as it is wide (within 25%)

    If all 3 conditions are met, the component is labelled as a heart.
    ****************************************************************
%}

function originalImage = findHeart(originalImage);

% array of component labels
colors = [];

for i = 1:size(originalImage,1)
    for j = 1:size(originalImage,2)
        if(originalImage(i,j) ~= 0)
            colors = union(colors, originalImage(i,j));
        end
    end
end

% array of component labels that are identified hearts
hearts = [];

for i = 1:size(colors,2)
    bb = getBoundingBox(originalImage, colors(i));
    lowestPoint = [-1, -1];
    topRow = [];
    for j = 1:size(originalImage,1)
        for k = 1:size(originalImage,2)
            if(originalImage(j,k) == colors(i))
                if(lowestPoint(1) == -1 || lowestPoint(1) < j)
                    lowestPoint = [j, k];
                end
                if(j == bb(3))
                    topRow = union(topRow, k);
                end
            end
        end
    end
    humps = 0;
    if(size(topRow,2) > 1)
        for j = 2:size(topRow,2)
            if(topRow(j) ~= topRow(j-1) + 1)
                humps = 1;
                break;
            end
        end
    end
    width = bb(2) - bb(1) + 1;
    height = bb(4) - bb(3) + 1;
    middleX = (bb(1) + bb(2))/2;
    % lowest point must be within 10% of center x
    if(lowestPoint(2) > middleX * .9 && lowestPoint(2) < middleX * 1.1)
        % check for two humps on top reaching the same y
        if(humps == 1)
            % width must be within 25% of the height (relatively square)
            if(width > height * .75 && width < height * 1.25)
                % if all of these conditions pass, it is a heart
                hearts = union(hearts, colors(i));
            end
        end
    end
end

% create figure
heartFound = imagesc(originalImage);

% set figure text
originalImage = setFigureText(originalImage);

% add heart label to identified components
for n = 1:size(hearts, 2)
    component = hearts(n);
    heartBox = getBoundingBox(originalImage, component);
    x = heartBox(2) + heartBox(1);
    x = x / 2;
    y = heartBox(4) + heartBox(3);
    y = y / 2 - 2;
    
    text(x,y,'heart', 'FontSize', 24);
end

% save figure with heart labelled
saveas(heartFound,'extra_credit.png');

end