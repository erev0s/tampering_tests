function [percentageWhite] = getWhitePercent(path)
imageSize = 1500*2000;


% im = imread(path);
im = path;
try
    im = rgb2gray(im);
catch
end

allWhite = sum(sum(im));
percentageWhite = allWhite/imageSize*100;