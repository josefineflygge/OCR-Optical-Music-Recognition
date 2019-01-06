function [subIm, subRows] = subImage(Im, rows)
%% Divide image into subimages for every staff bar

    height = 400; 

    lastLine = max(rows); % Last staff line
    firstLine = min(rows); % First staff line


    dist = lastLine - firstLine; % Distance between first and last staff line

    space = dist/18; % Half the space between staff lines
    extra = ceil(space * 2); % Additional space added before and after staffs

    ImCrop = Im(firstLine-extra:lastLine+extra, :); % Crop image
    scale = height/dist;
    subIm = imresize(ImCrop, height/dist); % Scale image
    
    subRows = (rows - (firstLine-extra)) .* scale; % The rows places in the subImage
 
end

