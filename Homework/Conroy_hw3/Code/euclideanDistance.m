%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #3
    euclideanDistance.m

    function that calculates the Euclidean distance for each pixel
    from the mean for each cluster
    ****************************************************************
%}

function dist = euclideanDistance(pixel, means, currentIteration)

    K = size(means,1);
    dims = size(means,3);

    dist = zeros(1,K);
    
    for k = 1:K
        sum = 0;
        for l = 1:dims
            sum = sum + (double(pixel(l)) - means(k, currentIteration, l))^2;
        end
        dist(k) = sum;
    end   
    
end
