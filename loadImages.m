function [ imgs ] = loadImages(directoryPath)
    %
    % Read all images from directoryPath
    %
    % Arguments:
    % directoryPath − A string with the directory path
    %
    % Returns
    % imgs − 4 dimensional vector, where imgs(:,:,:,k) is the k−th
    % image in RGB format.
    %
    files = dir(directoryPath);
    j = 1;
    found = false;
    for i = 1:length(files)
        if ~(strcmp(files(i).name, '.') || strcmp(files(i).name, '..'))
            if ~found
                firstIm = imReadAndConvert(strcat(directoryPath, '/', files(i).name), 2);
                imgs = zeros([size(firstIm), length(files) - 2]);
                imgs(:,:,:,j) = firstIm;
                j = j + 1;
                found = true;
            else
                imgs(:,:,:,j) = imReadAndConvert(strcat(directoryPath, '/', files(i).name), 2);
                j = j + 1;
            end
        end
    end
end

