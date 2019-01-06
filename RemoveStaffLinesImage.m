function [RemovedStaffsImage] = RemoveStaffLinesImage(Im)
    seLineVer = strel('line', 15, 90);
    RemovedStaffsImage = imopen(Im, seLineVer);
end

