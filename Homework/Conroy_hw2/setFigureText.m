%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #2
    setFigureText.m

    This method adds text to figures in order to display the labels
    (pixel values) in the center of the components.
    ****************************************************************
%}

function originalImage = setFigureText(originalImage)

colors = [];

for i = 1:size(originalImage,1)
    for j = 1:size(originalImage,2)
        if(originalImage(i,j) ~= 0)
            colors = union(colors, originalImage(i,j));
        end
    end
end

% find middle of bounding box, put text label in the center on the figure
for i = 1:size(colors,2)
    bb = getBoundingBox(originalImage, colors(i));
    x = bb(2) + bb(1);
    x = x / 2;
    y = bb(4) + bb(3);
    y = y / 2;
    
    text(x,y,num2str(colors(i)), 'FontSize', 24);
end

% add text label to background
flag = 0;
for i = 1:size(originalImage,1)
    for j = 1:size(originalImage,2)
        if(originalImage(i,j) == 0)
            text(i,j,'0', 'FontSize', 24);
            flag = 1;
            break;
        end
    end
    if(flag == 1)
        break;
    end
end

end