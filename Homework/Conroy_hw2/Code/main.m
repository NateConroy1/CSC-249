%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #2
    main.m

    The main method which drives the program. Run this file.
    ****************************************************************
%}

% read in original image
originalImage = imread('shapes-blurred.png');

% convert the image to a binary map (pixel values of 0 and 255)
originalImage = getBinMap(originalImage);

% get the connected components, and display results
originalImage = getConnectedComponents(originalImage);

% remove the selected regions and display results
originalImage = removeSmallRegions(originalImage);

% remove the skinny regions (aspect ratios over 3:1) and display results
originalImage = removeSkinnyRegions(originalImage);

% extra credit: find heart in image
originalImage = findHeart(originalImage);