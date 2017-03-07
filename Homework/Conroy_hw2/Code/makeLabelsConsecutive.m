%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #2
    makeLabelsConsecutive.m

    This method takes in an image and assigns new labels (pixel
    values) to connected components in increasing sequential order.
    ****************************************************************
%}

function originalImage = makeLabelsConsecutive(originalImage)

consec = [];

for i = 1:size(originalImage,1)
    for j = 1:size(originalImage,2)
        if(originalImage(i,j) ~= 0)
            index = find(consec == originalImage(i,j));
            if(isempty(index))
                consec = [consec, originalImage(i,j)];
                originalImage(i,j) = size(consec,2);
            else
                originalImage(i,j) = index;
            end
        end
    end
end

end