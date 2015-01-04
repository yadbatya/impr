function [cellT] = LKregister(imgs)
    cellT = cell(1);
    for i = 1:size(imgs, 4) - 1
        img1 = rgb2gray(imgs(:, :, :, i));
        img2 = rgb2gray(imgs(:, :, :, i + 1));
        minDim = min(size(img1));
        levels = 1;
        while floor(minDim/2) >= 30
            minDim = minDim / 2;
            levels = levels + 1;
        end
        gp1 = GaussianPyramid(img1, levels, 3);
        gp2 = GaussianPyramid(img2, levels, 3);
        guess = [0, 0];
        
%         levels = 2;
        
        for j=levels:-1:1
            
%             iters = 0;
            
            guess = 2*guess;
            im1 = gp1{j};
            im2 = gp2{j};
            Ix = conv2(im2, [1, 0, -1; 2, 0, -2; 1, 0, -1]/8, 'same');
            Iy = conv2(im2, [1, 2, 1; 0, 0, 0; -1, -2, -1]/8, 'same');
            
            Ix = Ix(3:end-2, 3:end-2);
            Iy = Iy(3:end-2, 3:end-2);
            
            A = zeros(2, 2);
            A(1, 1) = sum(Ix(:).^2);
            A(1, 2) = sum(Ix(:).*Iy(:));
            A(2, 1) = A(1, 2);
%             A(2, 1) = sum(Iy(:).*Ix(:));
            A(2, 2) = sum(Iy(:).^2);
            convergance = false;
            while ~convergance
%                 iters = iters + 1;
%                 if iters == 100000
%                     display('break')
%                     break
%                 end
               im3 = interp2(im1, (1:size(im1, 2))-guess(1), (1:size(im1, 1))'-guess(2));
               
               im3(isnan(im3)) = 0;
               
               filter = conv2([1 2 1], [1;2;1]);
               filter = filter / sum(filter(:));
               im3 = conv2(im3, filter, 'same');
               im2f = conv2(im2, filter, 'same');
               
               
               It = im2f - im3;
               
               
               
               
               
               It = It(3:end-2, 3:end-2);
%                convergance = (sum(It(:) < 0.001) == 0);
               
%                
%                figure, imshow(im1);
%                    figure, imshow(im2);
%                    figure, imshow(im3);
%                    figure, imshow(It);
               
                   
%                    if convergance
%                    figure, imshow(im1);
%                    figure, imshow(im2);
%                    figure, imshow(im3);
%                    figure, imshow(It);
%                    break
%                end
               
               
%                close all
               
               
               b1 = Ix.*It;
               b2 = Iy.*It;
               b = -[sum(b1(:)), sum(b2(:))];
               addedGuess = linsolve(A, b');
               addedGuess(isnan(addedGuess)) = 0;
               eps = 0.01;
               convergance = abs(addedGuess(1)) < eps && abs(addedGuess(2)) < eps;
               guess = guess + addedGuess';
            end
        end
        cellT{i} = [1, 0, guess(1); 0, 1, guess(2); 0, 0, 1];
    end

end

