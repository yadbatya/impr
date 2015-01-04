function [T, inliners] = ransacTransform(pos1, pos2, numIters, inlinerTol)
    % Fit transform to maximal inliers given point matches
    % using the RANSAC algorithm.
    %
    % Arguments:
    % pos1,pos2 − Two nx2 matrices containing n rows of [x,y] coordinates of
    % matched points.
    % numIters − Number of RANSAC iterations to perform.
    % inlierTol − inlier tolerance threshold. When determining if a given match,
    % e.g. between pos1(i,:) and pos2(i,:), is an inlier match, the squared euclidean
    % distance between the transformed pos1(i,:) and pos2(i,:) is computed and
    % compared to inlierTol. Matches having this squared distance smaller than
    % inlierTol are treated as inliers.
    %
    % Returns:
    % T − A 3x3 matrix, where T(1,3) is dX and T(2,3) is dY.
    % inliers − An array containing the indices in pos1/pos2 of the maximal set of
    % inlier matches found.
    %
    % Description:
    % To determine if a given match, e.g. between pos1(i,:) and pos2(i,:), is an
    % inlier match, the squared euclidean distance between the transformed pos1(i,:)
    % and pos2(i,:) is computed and compared to inlierTol. Matches having this squared
    % distance smaller than inlierTol are deemed inliers.
    inliners = [];
%     T = [];
    
    
%     numIters = length(pos1);
    
    
    for i = 1:numIters
        j = randi(length(pos1));
        
        
%         j = i;
        
        
        p1 = pos1(j, :);
        p2 = pos2(j, :);
        dx = p2(1) - p1(1);
        dy = p2(2) - p1(2);
        curT = [1, 0, dx; 0, 1, dy; 0, 0, 1];
        hpos1 = [pos1, ones(length(pos1), 1)];
%         hpos2 = [pos2, ones(length(pos2), 1)];
        check = (curT * hpos1')';
        check = check(:, 1:2);
        check = check - pos2;
        curInliners = calcDist(check, inlinerTol);
        if length(curInliners) > length(inliners)
            inliners = curInliners;
%             T = curT;
        end
    end
    dx = mean(pos2(inliners, 1) - pos1(inliners, 1));
    dy = mean(pos2(inliners, 2) - pos1(inliners, 2));
    T = [1, 0, dx; 0, 1, dy; 0, 0, 1];
end

function [inliners] = calcDist(check, inlinerTol)
    % returns the inliners from check that are in inlinerTol distance from
    % (0, 0)
    inliners = zeros(length(check), 1);
    amount = 0;
    for i = 1:size(check, 1);
        if norm(check(i, :))^2 < inlinerTol
            amount = amount+ 1;
            inliners(amount) = i;
        end
    end
    inliners = inliners(1:amount);
end