%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #2
    getBoundingBox.m

    This method returns an array of size 4 with the min x, max x,
    min y, and max y of a component's bounding box when given the
    image and the label value.
    ****************************************************************
%}

function boundingBox = getBoundingBox(originalImage, label)

% boundingBox = [min X, max X, min Y, max Y]
boundingBox = [-1, -1, -1, -1];

for i = 1:size(originalImage,1)
    for j = 1:size(originalImage,2)
        if(originalImage(i,j) == label)
            if(boundingBox(1) == -1 || boundingBox(1) > j)
                boundingBox(1) = j;
            end
            if(boundingBox(2) == -1 || boundingBox(2) < j)
                boundingBox(2) = j;
            end
            if(boundingBox(3) == -1 || boundingBox(3) >  i)
                boundingBox(3) = i;
            end
            if(boundingBox(4) == -1 || boundingBox(4) < i)
                boundingBox(4) = i;
            end
        end
    end
end

end