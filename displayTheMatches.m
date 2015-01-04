function [] = displayTheMatches(im1, im2, pos1, pos2, inlind)
    % DISPLAYMATCHES Display matched pt. pairs overlayed on given image pair.
    % Arguments:
    % im1,im2 − two grayscale images
    % pos1,pos2 − nx2 matrices containing n rows of [x,y] coordinates of matched
    % points in im1 and im2 (i.e. the i’th match’s coordinate is
    % pos1(i,:) in im1 and and pos2(i,:) in im2).
    % inlind − k−element array of inlier matches (e.g. see output of
    % ransacTransform.m)
    im = [im1, im2];
    figure, imshow(im);
    hold on;
    moved = pos2;
    moved(:, 1) = size(im1, 2) + moved(:, 1);
%     plot(pos1, moved, 'r.');
    plot(pos1(:, 1), pos1(:, 2), 'r.');
%     plot(pos1(:, 1), pos1(:, 2),'y-',pos1(:, 1), pos1(:, 2),'go')
    plot(moved(:, 1), moved(:, 2), 'r.');
    in1 = pos1(inlind, :);
    in2 = pos2(inlind, :); 
    in2(:, 1) = size(im1, 2) + in2(:,1);
    x = [in1(:,1), in2(:,1)];
    y = [in1(:,2), in2(:,2)];
    plot(x', y', 'y-')
    
%     in1 = pos1;
%     in2 = pos2;
%     in1(inlind, :) = [];
%     in2(inlind, :) = []; 
%     in2(:, 1) = size(im1, 2) + in2(:,1);
%     x = [in1(:,1), in2(:,1)];
%     y = [in1(:,2), in2(:,2)];
%     plot(x', y', 'b-')
    
%     plot(pos1(inlind), 'g-');
end

