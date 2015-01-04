function [pos, desc] = findFeatures(pyr, maxNum)
    % FINDFEATURES Detect feature points in pyramid and sample their descriptors.
    % Arguments:
    % pyr − Gaussian pyramid of a grayscale image having at least 3 levels.
    % maxNum − Sets the maximal number of feature points to detect.
    % Returns:
    % pos − An nx2 matrix of [x,y] feature positions per row found in pyr. These
    % coordinates are provided at the pyramid level pyr{1}.
    % desc − A kxkxn feature descriptor matrix.
    pos = spreadOutCorners(pyr{1}, 7, 7, maxNum);
%     figure, imshow(pyr{1});
%     hold on
%     plot(pos(:,1),pos(:,2),'r.');
%     plot(pos(:,2),pos(:,1),'g.');
    desc = sampleDescriptor(pyr{3}, pos, 3);
end

