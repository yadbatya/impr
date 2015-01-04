function [desc] = sampleDescriptor(im, pos, descRad)
    % SAMPLEDESCRIPTOR Sample a MOPS−like descriptor at given position in image.
    % Arguments:
    % im − nxm grayscale image to sample within.
    % pos − A nx2 matrix of [x,y] descriptor positions in im.
    % descRad − �?Radius�? of descriptors to compute (see below).
    % Returns:
    % desc − A kxkxn 3−d matrix containing the ith descriptor
    % at desc(:,:,i). The per−descriptor dimensions kxk are related to the
    % descRad argument as follows k = 1+2∗descRad.
    desc = zeros(1 + 2*descRad, 1 + 2*descRad, size(pos, 1));
    j = 1;
%     figure, imshow(im);
    for i = pos'
       curDesc = singleDescriptor(im, i, descRad);
       if ~isnan(curDesc)
%            figure, imshow(curDesc, []);
           desc(:, :, j) = curDesc;
           j = j + 1;
       end
    end
    desc = desc(:, :, 1:j-1);
end

function desc = singleDescriptor(im, loc, rad)
    % samples a single descriptor
    xy = 0.25*(loc - 1) + 1;
    if xy(1) - rad < 1 || xy(1) + rad > size(im, 2) ||  xy(2) - rad < 1 || xy(2) + rad > size(im, 1)
        desc = NaN;
    else
        region = interp2(im, (xy(1) - rad):(xy(1) + rad), ((xy(2) - rad):(xy(2) + rad))');
        regionMean = mean(region(:));
        desc = (region - regionMean) ./ norm(region(:) - regionMean);
    end
end