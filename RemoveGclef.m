function [newIm] = RemoveGclef(subIm)

height = 370; 
gIm = rgb2gray(imread('gclefLines.png')); % Read g clef template
gIm = BinaryImage(gIm); % Make g clef template binary

gIm = imresize(gIm, height/size(gIm,1)); % Scale g clef image to match the height of subIm

corr = normxcorr2(gIm, subIm); % Correlation between image and g clef
[ypeak, xpeak] = find(corr==max(corr(:))); % Find the peak in cross-correlation.

newIm = subIm(:, xpeak:size(subIm,2));

end

