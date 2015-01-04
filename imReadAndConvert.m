function [out] = imReadAndConvert(filename, representation)
    im = imread(filename);
    if representation == 1
        info = imfinfo(filename);
        if strcmp(info.ColorType, 'grayscale')
            out = im2double(im);
        else
            out = rgb2gray(im2double(im));
        end
    elseif representation == 2
        out = im2double(im);
    else
        display('representation must be either 1 or 2');
        return
    end
end

