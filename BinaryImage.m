function [ ImBin ] = BinaryImage( Im )
%Make image binary
level = graythresh(Im); %create treshhold
%Convert the image into a binary image
ImBin = imbinarize(Im,level);
ImBin = ImBin < level;
end

