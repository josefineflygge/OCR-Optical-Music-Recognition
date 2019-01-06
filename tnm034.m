function strout = tnm034(Im)
% Im: Input image of captured sheet music. Im should be in 
% double format, normalized to the interval [0,1]
% strout: The resulting character string of the detected notes.

% String to store the notes
    noteStr = '';

% Image to double format
Im = im2double(Im);
Im = rgb2gray(Im);

% Normalize image to interval [0,1]
Im = Im - min(Im(:));
Im = Im / max(Im(:));


%ImBin = BinaryImage(Im); % Binary image
ImRotCrop = RotateAndCropImage(Im); % Rotate and crop image
ImLines = StaffLineImage(BinaryImage(ImRotCrop)); % Staff line image
rows = FindStaffLines(ImLines);

%% Divide image into subimages of every staffbar 
for barNr = 1: length(rows(:,1))
    % Divide into subimages and scale the rows to the subimage
    [subIm, subRows] = subImage(BinaryImage(ImRotCrop), rows(barNr,:));

    % Remove g clef
    subIm = RemoveGclef(subIm);
    
    % Create image without staff lines
    noStaffLinesIm = RemoveStaffLinesImage(subIm);
    
    % Create image without double flags
    ImWithoutDoubleFlags = RemoveDoubleFlags(noStaffLinesIm);

    % Find heads on every subimage and determine the lines on every staff bar.
    [heads, headsIm] = findHeads(ImWithoutDoubleFlags);
    
    % Create image with just flags and beams
    noStemsIm = RemoveStemsImage(noStaffLinesIm);
    flagsBeamsIm = imabsdiff(noStemsIm, headsIm);
    
    % Find rythm
    rythm = DetermineRythm(flagsBeamsIm, heads);
   
    % Match heads with closesed row or mid
     for h = 1:length(heads.Centroid(:,1))
         noteStr = strcat(noteStr, findNote(subRows, heads.Centroid(h,2), rythm(h)));
     end
    
    
     % Add 'n' to string after every bar, except the last one
     if(barNr ~= length(rows(:,1))) 
         noteStr = strcat(noteStr, 'n'); 
     end

strout = noteStr;
end

