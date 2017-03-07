%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #2
    getMin.m

    This simple method returns the minimum value of an array.
    ****************************************************************
%}

function min = getMin(array)
    min = array(1);
    for i = 1:size(array)
        if(array(i) < min)
            min = array(i);
        end
    end
end