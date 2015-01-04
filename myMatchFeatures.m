function [ind1, ind2] = myMatchFeatures(desc1, desc2, minScore)
    % MYMATCHFEATURES Match feature descriptors in desc1 and desc2.
    % Arguments:
    % desc1 − A kxkxn1 feature descriptor matrix.
    % desc2 − A kxkxn2 feature descriptor matrix.
    % minScore − Minimal match score between two descriptors required to be
    % regarded as matching.
    % Returns:
    % ind1,ind2 − These are m−entry arrays of match indices in desc1 and desc2.
    %
    % Note:
    % 1. The descriptors of the ith match are desc1(ind1(i)) and desc2(ind2(i)).
    % 2. The number of feature descriptors n1 generally differs from n2
    % 3. ind1 and ind2 have the same length.
    
    
%     ind1 = zeros(size(desc1, 3) * size(desc2, 3), 1);
%     ind2 = zeros(size(ind1));
%     k = 1;
%     for i = 1:size(desc1, 3)
%         row1 = desc1(:, :, i);
%         row1 = row1(:);
%         for j = 1:size(desc2, 3)
%             row2 = desc2(:, :, j);
%             row2 = row2(:);
%             score = dot(row1, row2);
%             if score >= minScore
% %             score = norm(row1-row2);
% %             if score < minScore
%                ind1(k) = i;
%                ind2(k) = j;
%                k = k + 1;
%             end
%         end
%     end
%     ind1 = ind1(1:(k - 1));
%     ind2 = ind2(1:(k - 1));
    

    ind1 = zeros(size(desc1, 3), 1);
    ind2 = zeros(size(ind1));
    k = 1;
    for i = 1:size(desc1, 3)
        row1 = desc1(:, :, i);
        row1 = row1(:);
        highest = 0;
        best = [];
        for j = 1:size(desc2, 3)
            row2 = desc2(:, :, j);
            row2 = row2(:);
            score = dot(row1, row2);
            if score >= minScore
                if score > highest
                    highest = score;
                    best = [i, j];
                end
%             score = norm(row1-row2);
%             if score < minScore
            end
        end
        if highest > 0
            ind1(k) = best(1);
            ind2(k) = best(2);
            k = k + 1;
        end
    end
    ind1 = ind1(1:(k - 1));
    ind2 = ind2(1:(k - 1));



end

