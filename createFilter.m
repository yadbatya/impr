function [filter] = createFilter(filterSize)
%     creates a 1d gaussian filter of size filerSize
    filter = 1;
    for i = 1:(filterSize - 1)
        filter = conv2(filter, [1 1]);
    end
    filter = filter / sum(filter(:));
end