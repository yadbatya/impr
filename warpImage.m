function im2 = warpImage(im1, T12)
[x1,y1] = meshgrid(1:size(im1,2),1:size(im1,1));
m = [x1(:), y1(:), ones(size(x1, 1)*size(x1,2), 1)];
m2 = T12 * m';
x2 = m2(1, :);
y2 = m2(2, :);
x2 = reshape(x2, size(x1));
y2 = reshape(y2, size(y1));
im2r = interp2(x1,y1,im1(:,:,1),x2,y2,'linear');
im2g = interp2(x1,y1,im1(:,:,2),x2,y2,'linear');
im2b = interp2(x1,y1,im1(:,:,3),x2,y2,'linear');
im2 = cat(3, im2r, im2g, im2b);
im2(isnan(im2)) = 0;
end