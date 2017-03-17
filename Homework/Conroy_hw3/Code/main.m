%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #3
    main.m

    The main method which drives the program. Run this file.
    ****************************************************************
%}

% constants
RGB = 1;
LST = 2;
HSV = 3;

% read in original image
peppers = imread('Images/peppersRGB.tif');

K = 5; % EDIT THIS VALUE TO CHANGE NUMBER OF CLUSTERS
% K = 4;
% K = 3;
% K = 2;

color_space = RGB; % EDIT THIS VALUE TO LST OR HSV TO CHANGE COLOR SPACE!
% color_space = LST
% color_space = HSV

if(color_space == LST)
    for i = 1:size(peppers,1)
        for j = 1:size(peppers, 2)
            rgb_vector = peppers(i,j,:);
            Lst_vector = zeros(1,3);
            % set L
            Lst_vector(1) = (double(rgb_vector(1)) + double(rgb_vector(2)) + double(rgb_vector(3)))/3;
            % set s
            Lst_vector(2) = (double(rgb_vector(1))-double(rgb_vector(3)))/2;
            % set t
            Lst_vector(3) = (2 * double(rgb_vector(2)) - double(rgb_vector(1)) - double(rgb_vector(3)))/4;
            
            peppers(i,j,:) = Lst_vector;
        end
    end
else
    if(color_space == HSV)
        peppers = rgb2hsv(peppers);
    end
end

maxIterations = 30; % maximum number of iterations
dims = 3; % feature vector dimensions
means = zeros(K, maxIterations, dims); % initialize means array
result = zeros(size(peppers,1), size(peppers, 2)); % 2D array of labels

% set initial means for K clusters
% (for the number of K clusters specified above)
means(1,1,:) = 10;
means(2,1,:) = 20;
means(3,1,:) = 30;
means(4,1,:) = 40;
means(5,1,:) = 50;

for currentIteration = 1:maxIterations
    
    % --------------
    %    M - STEP 
    % --------------

    KCounts = zeros(1,K);

    % perform Euclidean distance calculation and assign labels
    for i = 1:size(peppers,1)
        for j = 1:size(peppers,2)
            dist = euclideanDistance(peppers(i,j,:), means, currentIteration);
            min = 1;
            for k = 2:K
                if(dist(min) > dist(k))
                    min = k;
                end
            end
            result(i,j) = min;
            KCounts(min) = KCounts(min) + 1;
            if(currentIteration ~= maxIterations)
                for n = 1:dims
                    means(min, currentIteration + 1, n) = means(min, currentIteration + 1, n) + double(peppers(i,j,n));
                end
            end
        end
    end
    
    % --------------
    %    E - STEP 
    % --------------

    % update the K means
    if(currentIteration ~= maxIterations)
        for i = 1:K
            for j = 1:dims
               means(i, currentIteration + 1, j) = means(i, currentIteration + 1, j) / KCounts(i);
            end
        end
    end
    
    % check if distance between iterations is less than T (.01) for all k
    if(currentIteration ~= 1)
        if(checkT(means, currentIteration) == 0)
            break
        end
    end

end

fig = imagesc(result);
saveas(fig, 'Images/test.png');
