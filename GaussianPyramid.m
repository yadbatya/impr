function [pyr, filter] = GaussianPyramid(im, maxLevels, filterSize)
    % creates a guasssian pyramid with maxLevels levels
    tempIm = im;
    filter = createFilter(filterSize);
    pyr = cell(maxLevels, 1);
    realLevels = maxLevels;
    pyr{1} = im;
    for i = 2:maxLevels
        if size(tempIm, 1) >= 32 && size(tempIm, 2) >= 32
            tempIm = conv2(tempIm, filter, 'same');
            tempIm = conv2(tempIm, filter', 'same');
            tempIm = tempIm(1:2:end, 1:2:end);
            pyr{i} = tempIm;
        else
            realLevels = i-1;
            break;
        end
    end
    pyr = pyr(1:realLevels);
end

