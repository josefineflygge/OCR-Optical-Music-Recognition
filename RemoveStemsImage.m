function [RemovedStemsIm] = RemoveStemsImage(Im)

    seLineHor = strel('line', 12, 0);
    ImNoLines = imopen(Im, seLineHor);
    RemovedStemsIm = ImNoLines; 

end

