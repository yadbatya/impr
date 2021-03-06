function [panoramaFrame, frameNotOK] = renderPanoramicFrame(panoSize, imgs, T, imgSliceCenterX, halfSliceWidthX)
    %
    % The function render a panoramic frame. It does the following:
    % 1. Convert centers into panorama coordinates and find optimal width of
    % each strip.
    % 2. Backwarpping each strip from image to the panorama frames
    %
    % Arguments:
    % panoSize − [yWidth,xWidth] of the panorama frame
    % imgs − The set of M images
    % T − The set of transformations (cell array) from each image to
    % the panorama coordinates
    % imgSliceCenterX − A vector of 1xM with the required center of the strip
    % in each of the images. This is given in image coordinates.
    % sliceWidth − The suggested width of each strip in the image
    %
    % Returns:
    % panoramaFrame− the rendered frame
    % frameNotOK − in case of errors in rednering the frame, it is true.
    panoramaFrame = zeros([panoSize, 3]);
    
    TcenterX = zeros(size(imgSliceCenterX));
    bounds = zeros(length(imgSliceCenterX)+ 1,1);
    for i=1:length(imgSliceCenterX)
        TcenterX(i) = imgSliceCenterX(i) - T{i}(1,3);
    end
    bounds(1) = TcenterX(1) - halfSliceWidthX;
    for i=1:length(imgSliceCenterX)-1
        bounds(i+1) = (TcenterX(i) + TcenterX(i+1))/2;
    end
    bounds(length(imgSliceCenterX)+1) = TcenterX(length(imgSliceCenterX)) + halfSliceWidthX;
    xIdx = 1;
    for i=1:size(imgs, 4)
        img = imgs(:, :, :, i);
        [x1,y1] = meshgrid(round(bounds(i))+1:round(bounds(i+1)), 1:size(img,1));
        m = [x1(:), y1(:), ones(size(x1, 1)*size(x1,2), 1)];
        m2 = T{i} * m';
        x2 = m2(1, :);
        y2 = m2(2, :);
        x2 = reshape(x2, size(x1));
        y2 = reshape(y2, size(y1));
%         im2r = interp2(x1,y1,img(:,:,1),x2,y2,'linear');
%         im2g = interp2(x1,y1,img(:,:,2),x2,y2,'linear');
%         im2b = interp2(x1,y1,img(:,:,3),x2,y2,'linear');
        im2r = interp2(img(:,:,1),x2,y2,'linear');
        im2g = interp2(img(:,:,2),x2,y2,'linear');
        im2b = interp2(img(:,:,3),x2,y2,'linear');

        im2 = cat(3, im2r, im2g, im2b);
        im2(isnan(im2)) = 0;
        panoramaFrame(:, (xIdx:xIdx + size(im2, 2)-1), :) = im2;
        xIdx = xIdx + size(im2, 2);
%         panoramaFrame(:, round(bounds(i))+1:round(bounds(i+1)), :) = im2; 
    end
%     panoramaFrame(:, 1:, :)
%     for i=1:size(imgs, 4)
% %         img = imgs(:, 1+(imgSliceCenterX(i) - halfSliceWidth):(imgSliceCenterX(i) + halfSliceWidth), :, i);
%         img = imgs(:, :, :, i);
%         [x1,y1] = meshgrid(1+(imgSliceCenterX(i) - halfSliceWidth):(imgSliceCenterX(i) + halfSliceWidth),1:size(img,1));
%         m = [x1(:), y1(:), ones(size(x1, 1)*size(x1,2), 1)];
%         m2 = T{i} * m';
%         x2 = m2(1, :);
%         y2 = m2(2, :);
%         x2 = reshape(x2, size(x1));
%         y2 = reshape(y2, size(y1));
%         im2r = interp2(x1,y1,img(:,:,1),x2,y2,'linear');
%         im2g = interp2(x1,y1,img(:,:,2),x2,y2,'linear');
%         im2b = interp2(x1,y1,img(:,:,3),x2,y2,'linear');
%         im2 = cat(3, im2r, im2g, im2b);
%         im2(isnan(im2)) = 0;
%         panoramaFrame(:, 1+(i-1)*halfSliceWidth*2:i*halfSliceWidth*2, :) = im2; 
%     end
    frameNotOK = false;
end
