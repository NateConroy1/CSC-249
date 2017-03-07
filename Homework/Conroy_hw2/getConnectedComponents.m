%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #2
    getConnectedComponents.m

    This method implements the two pass connected component algorithm.
    ****************************************************************
%}

function originalImage = getConnectedComponents(originalImage)

% create a 2d array of zeros with the dimensions of the image
labels = zeros(size(originalImage,1), size(originalImage,2));

% create hashtable to keep track of equivalences
equivalence = java.util.Hashtable;

% unique label count
count = 1;

% -----------------
% FIRST PASS
% -----------------

for i = 1:size(originalImage,1)
    for j = 1:size(originalImage,2)
        
        neighbors = [];
        
        % if element is background
        if(originalImage(i,j) == 0)
            labels(i,j) = 0;
        else
            % get neighbors (and avoid going out of matrix ranges)
            if(i ~= 1 && originalImage(i-1,j) == originalImage(i,j))
                neighbors = [neighbors, labels(i-1,j)];
            end
            if(i ~= 1 && j ~= 1 && originalImage(i-1,j-1) == originalImage(i,j))
                neighbors = [neighbors, labels(i-1,j-1)];
            end
            if(i ~= 1 && j ~= size(originalImage,2) && originalImage(i-1,j+1) == originalImage(i,j))
                neighbors = [neighbors, labels(i-1,j+1)];
            end
            if(j ~= 1 && originalImage(i,j-1) == originalImage(i,j))
                neighbors = [neighbors, labels(i,j-1)];
            end
            
            % if size of neighbors is 0, create a unique label
            if(size(neighbors, 2) == 0)
                labels(i,j) = count;
                if(size(equivalence) < count)
                    equivalence.put(count, [count]);
                end
                count = count + 1;
            else
                % else take minimum of neighbor labels
                a = neighbors(1,1);
                for k = 1:size(neighbors,2)
                    if(neighbors(1,k) < a)
                        a = neighbors(k);
                    end
                end
                labels(i,j) = a;
            end
            % mark equivalence
            if(size(neighbors,2) > 0)
                currentLabel = labels(i,j); % get label
                set = equivalence.get(currentLabel); % equivalence set of current pixel
                for k = 1:size(neighbors,2)
                    neighborLabel = neighbors(k); % get neighbor label
                    set2 = equivalence.get(neighborLabel); % equivalence set of neighbor pixel
                    C = union(set, set2);
                    equivalence.put(currentLabel, C);
                    equivalence.put(neighborLabel, C);
                end
            end            
        end
    end
end

% create figure
figure('visible','off','Position', [100, 100, 1049, 895]);
firstPass = imagesc(labels);

% set figure text
labels = setFigureText(labels);

saveas(firstPass, 'first_pass.png');

% -----------------
% SECOND PASS
% -----------------

for i = 1:equivalence.size()
    array = equivalence.get(i);
    for j = 1:size(array, 1)
        set2 = equivalence.get(array(j));
        D = union(array,set2);
        equivalence.put(array(j),D);
    end
end

for i = 1:size(labels,1)
    for j = 1:size(labels,2)
        if(labels(i,j) ~= 0)
            originalImage(i,j) = getMin(equivalence.get(labels(i,j)));
        end
    end
end

% make labels consecutive
originalImage = makeLabelsConsecutive(originalImage);

% create figure
result = imagesc(originalImage);

% set figure text
originalImage = setFigureText(originalImage);

saveas(result,'second_pass.png');

end
