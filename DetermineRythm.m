function [rythmArray] = DetermineRythm(Im, Heads)
    headsBB = Heads.BoundingBox;
    rythmArray = zeros(1, length(headsBB(:,1)));
    
    for h = 1:length(headsBB(:,1))
        x = max(headsBB(h,1)-headsBB(h,3), 1) : min(headsBB(h,1)+2*headsBB(h,3), size(Im,2));
        x = ceil(x);
        yOver = ceil(1:headsBB(h,2));
        yUnder = ceil(headsBB(h,2)+headsBB(h,4):size(Im, 1));
        over = Im(yOver, x);
        under = Im(yUnder, x);
        labelOver = bwareafilt(over,[700, 5000]);
        labelUnder = bwareafilt(under,[700, 5000]);
        
        objectsOver = bwconncomp(labelOver);
        objectsUnder = bwconncomp(labelUnder);
        nrOfObj = max(objectsOver.NumObjects, objectsUnder.NumObjects);
        rythmArray(h) = nrOfObj;
    end
end

