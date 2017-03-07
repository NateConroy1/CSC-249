function y = testFunction()

% test the grayscale converter with 2 different image types
imageToGrayscale('original_images/Ankur1.png');
imageToGrayscale('original_images/Ankur2.png');
imageToGrayscale('original_images/phase1.jpg');
imageToGrayscale('original_images/phase2.jpg');

% test the zoomImage function with the original images and the new grayscale images
zoomImage('grayscales/Ankur1_grayscale.png', 5);
zoomImage('grayscales/Ankur2_grayscale.png', 5);
zoomImage('grayscales/phase1_grayscale.jpg', 3);
zoomImage('grayscales/phase2_grayscale.jpg', 3);

% get histograms of the grayscale image patches to analyze intensity values
getHistogram('zooms/Ankur1_grayscale_zoom.png');
getHistogram('zooms/Ankur2_grayscale_zoom.png');
getHistogram('zooms/phase1_grayscale_zoom.jpg');
getHistogram('zooms/phase2_grayscale_zoom.jpg');

    function x = imageToGrayscale(filename)
        % this function takes in a filename of an image, reads in the image,
        % and saves a grayscale image to the "grayscales" folder
        % extra functionality: preserves the type of the original file
        % NOTE: USES MATHWORK'S IMAGE PROCESSING TOOLBOX FOR rgb2gray
        image1 = imread(filename);
        image2 = rgb2gray(image1);
        [path,name,extension] = fileparts(filename);
        path = 'grayscales/';
        outputName = strcat(path, name);
        outputName = strcat(outputName,'_grayscale');
        outputName = strcat(outputName, extension);   
        imwrite(image2, outputName);
    end

    function x = zoomImage(filename, zoomLevel)
        % this function takes in a filename of an image and a zoom level,
        % reads in the image, and saves a zoomed image to the "zooms" folder
        % extra functionalities: preserves the type of the original file,
        %       and allows the user to specify the zoom level
        image1 = imread(filename);
        iptsetpref('ImshowBorder','tight');
        fig = figure();
        set(gcf,'Visible', 'off'); 
        imshow(image1);
        zoom(zoomLevel);
        [path,name,extension] = fileparts(filename);
        path = 'zooms/';
        outputName = strcat(path, name);
        outputName = strcat(outputName,'_zoom');
        outputName = strcat(outputName, extension);
        saveas(fig, outputName);
        image2 = imread(outputName);
        image3 = rgb2gray(image2);
        imwrite(image3, outputName);
    end

    function x = getHistogram(filename)
        % this function takes in a filename of a grayscale image, reads in 
        % the image, and saves a histogram of the intensity values to the
        % "histograms" folder
        % extra functionality: preserves the type of the original file
        image1 = imread(filename);
        fig = figure;
        set(gcf,'Visible', 'off'); 
        imhist(image1);
        [path,name,extension] = fileparts(filename);
        path = 'histograms/';
        outputName = strcat(path, name);
        outputName = strcat(outputName,'_histogram');
        outputName = strcat(outputName, extension);
        saveas(fig, outputName);
    end
        
end