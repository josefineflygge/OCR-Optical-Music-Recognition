function [ImWithoutDoubleFlags] = RemoveDoubleFlags(Im)

% Label isolated objects

L = bwlabel(Im, 8); % returns matrix with labels for the connected objects in Im
EulerStatsTable = regionprops('table', L, 'EulerNumber'); %measure properties of each labeled region in L
BoundingBoxesTable = regionprops('table', L, 'BoundingBox');

% seLineVert = strel('line', 15, 0); % Create a flat linear, vertical structuring element
% Im = imopen(Im, seLineVert); % User structuring element to find lines´

BoundingBoxesMatrix = BoundingBoxesTable.Variables; % Set table to matrix
EulerStatsMatrix = EulerStatsTable.Variables;
EulerIndex = 0;

eulerNumb = length(EulerStatsMatrix(:,1));
BoxNumb = length(BoundingBoxesMatrix(:,1));

%to know which boxes (and pixels within) to ignore
RelevantBoxes = [];

for i=1:BoxNumb

    if(EulerStatsMatrix(i,:)< 0)
     % rectangle('Position', BoundingBoxesMatrix(i, :) ,'EdgeColor','r')
    RelevantBoxes = [RelevantBoxes; BoundingBoxesMatrix(i,:)];
    end
    
  
end    


if (~isempty(RelevantBoxes))

if (length(RelevantBoxes(:,1)) > 0)
  
for i=1:length(RelevantBoxes(:,1))
    
Im((floor(RelevantBoxes(i,2)):floor(RelevantBoxes(i,2)+RelevantBoxes(i,4)-1)), floor(RelevantBoxes(i,1)):floor((RelevantBoxes(i,1)+RelevantBoxes(i,3)-1))) = 0;
   
end

end

end

ImWithoutDoubleFlags = Im;

end

