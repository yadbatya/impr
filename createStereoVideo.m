function [stereoVid] = createStereoVideo(imgDirectory, nViews)
    %
    % This function gets an image directory and create a stereo movie with
    % nViews. It does the following
    %
    % 1. Match transform between pairs of images.
    % 2. Convert the transfromations to a common coordinate system.
    % 3. Determine the size of each panoramic frame.
    % 4. Render each view.
    % 5. Create a movie from all the views.
    %
    % Arguments:
    % imgDirectory − A string with the path to the directory of the images
    % nView − The number of views to extract from each image
    %
    % Returns:
    % stereoVid − a movie which includes all the panoramic views
    %
    imgs = loadImages(imgDirectory);
    stereoVid = repmat(struct('cdata', [], 'colormap', []), nViews, 1);
%     tic;
%     T = ransacRegister(imgs);
    T = LKregister(imgs);
    T = imgToPanoramaCoordinates(T);
%     toc;
%     tic;
%     panoSize = [size(imgs, 1), ceil(size(imgs, 2)*size(imgs, 4)/nViews)];
    sliceWidth = round(size(imgs,2)/nViews);
    panoSize = [size(imgs, 1), ceil(size(imgs, 2)+abs(T{end}(1,3)))-sliceWidth*(nViews - 1)];
    for i=1:nViews
        imgSliceCenterX = repmat(round((i - 1)*sliceWidth + sliceWidth/2), size(imgs, 4), 1);
        [panoramaFrame, frameNotOK] = renderPanoramicFrame(panoSize, imgs, T, imgSliceCenterX, sliceWidth/2);
        if ~frameNotOK
            stereoVid(i) = im2frame(panoramaFrame);
        end
    end
%     toc;
%     for i = 1:size(imgs, 4)
%         stereoVid(i) = im2frame(imgs(:, :, :, i));
%     end
end

