function [ ImRotCropt ] = RotateAndCropImage( Im )

% Rotate image
Im = imrotate(Im, -90, 'bicubic');

% Binary image
ImBin = BinaryImage(Im);

%% Detect staffs and rotate image
% Find angle of the strongest line with percision of 1 between -90 and 89
% degrees
[H, theta] = hough(ImBin);
numpeaks = 10;
peaks = houghpeaks(H, numpeaks);
thetaPeak = theta(peaks(1,2));

% Find the angle of the strongest line with a precision of 0.05 between
% theataPeak and teataPeak + 0.95
[H, theta] = hough(ImBin, 'Theta', thetaPeak-0.99:0.01:thetaPeak+0.99);
peaks = houghpeaks(H, numpeaks);
thetaPeak = theta(peaks(1,2));

Im = imrotate(Im, thetaPeak, 'bicubic');
Im = imrotate(Im, 90, 'bicubic');

%% Crop image
% Calculate the added pixels in y and x on every side
yMin = ceil(abs(tand(thetaPeak)) * size(Im,2));
xMin = ceil(abs(tand(thetaPeak)) * size(Im,1));


height = size(Im,1) - 2 * yMin; %Desired height
width = size(Im,2) - 2 * xMin; %Desired width

safetydelete = 10; % To crop a bit more than calculated 

rect = [xMin yMin width height] + [safetydelete safetydelete -safetydelete -safetydelete];
ImRotCropt = imcrop(Im, rect);

end

