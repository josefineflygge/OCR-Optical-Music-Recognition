function [heads, headsIm] = findHeads(Im)
%% Extract heads from image
% Opening with circular element to find heads
seLineDisk = strel('disk', 19); % Create a circular structuring element
ImDisk = imopen(Im, seLineDisk); % User structuring element to find circles

headsIm = ImDisk;

%% Find and leabel heads
label = bwlabel(ImDisk, 8); % Label all objects
heads = regionprops('table', label); % Find meassurements of the head-objects

end

