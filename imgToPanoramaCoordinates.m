function [Tout] = imgToPanoramaCoordinates(Tin)
    % Tout{k} transforms image i to the coordinates system of the Panorama Image.
    %
    % Arguments:
    % Tin − A set of transformations (cell array) such that T i transfroms
    % image i+1 to image i.
    %
    % Returns:
    % Tout − a set of transformations (cell array) such that T i transforms
    % image i to the panorama corrdinate system which is the the corrdinates
    % system of the first image.
    Tout = cell(length(Tin) + 1, 1);
    Tout{1} = eye(3);
    for i = 2:length(Tout)
       Tout{i} = Tout{i-1}*Tin{i - 1}; 
    end
end

