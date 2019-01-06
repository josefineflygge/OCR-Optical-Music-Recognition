function [ImNoLines] = RemoveLinesImage(ImBin)
    seLineVer = strel('line', 5, 90);
    ImNoLines = imopen(ImBin, seLineVer);
end

