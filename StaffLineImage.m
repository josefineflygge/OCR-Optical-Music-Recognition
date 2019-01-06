function [ImLines] = StaffLineImage(ImBin)
%% Remove everything but staff lines
seLineHorizontal = strel('line', 3, 0); % Create a flat linear, horizontal structuring element
ImLines = imopen(ImBin, seLineHorizontal); % User structuring element to find staffs
ImLines = bwmorph(ImLines, 'tophat', 4); % Find staffs

seLineHorizontal = strel('line', 20, 0); % Create a flat linear, horizontal structuring element
ImLines = imclose(ImLines, seLineHorizontal); % Close objects horizontaly with structuringelement
ImLines = bwareaopen(ImLines, 15); % Delete unconnected objects of 15 pixels or less

end

