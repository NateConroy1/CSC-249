%{ 
    ****************************************************************
    Nathan Conroy
    CSC 249, Spring 2017
    Homework #4
    main.m

    The main method which drives the program. Run this file.
    ****************************************************************
%}

% get the original image
originalImage = imread('images/original_image_binary.png');

% extract the boundary points
originalImage = extractBoundaryPoints(originalImage);
imwrite(originalImage, 'images/extracted_boundary_points.png');

% perform the Hough Transform
accumulatorArray = houghTransform(originalImage);