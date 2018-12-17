function [percentageWhite] = getWhitePercent(path)
imageSize = 1500*2000;


im = path;
    
allWhite = sum(sum(im));
percentageWhite = allWhite/imageSize*100;