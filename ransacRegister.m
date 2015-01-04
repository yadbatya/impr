function [cellT] = ransacRegister(imgs)
    % returns cell of tranforms between following images
    cellT = cell(1);
    cellDesc = cell(1);
    pos = cell(1);
    for i = 1:size(imgs, 4)
        img = rgb2gray(imgs(:, :, :, i));
        [pos{i}, cellDesc{i}] = findFeatures(GaussianPyramid(img, 3, 7), 600);
    end
    for i = 1:(size(imgs, 4) - 1)
        cellT{i} = getT(cellDesc{i}, cellDesc{i+1}, pos{i}, pos{i+1}, imgs(:, :, :, i), imgs(:, :, :, i + 1));
    end
end

function [T] = getT(desc1, desc2, pos1, pos2, im1, im2)
    [matchers1, matchers2] = myMatchFeatures(desc1, desc2, 0.8);
    [T, inliners] = ransacTransform(pos1(matchers1, :), pos2(matchers2, :), 100, 10);
    displayTheMatches(im1, im2, pos1(matchers1, :), pos2(matchers2, :), inliners);
end

