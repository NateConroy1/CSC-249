%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #3
    checkT.m

    function that checks to see whether the distance between
    iterations is less than a threshold T (.01) for all clusters
    ****************************************************************
%}

function x = checkT(means, currentIteration)

    K = size(means,1);
    dim = size(means,3);

    x = 0;

    for i = 1:K
        sum = 0;
        for j = 1:dim
            sum = sum + (means(i, currentIteration-1, j) - means(i, currentIteration, j))^2;
        end
        if(sum >= .01)
            x = 1;
            break
        end
    end
    
end