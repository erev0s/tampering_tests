% Copyright (C) 2016 Markos Zampoglou
% Information Technologies Institute, Centre for Research and Technology Hellas
% 6th Km Harilaou-Thermis, Thessaloniki 57001, Greece

close all; clear all;
im1='C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-forged/dev_0001.jpg'
subplot(2,2,1);
imshow(CleanUpImage(im1));
subplot(2,2,3);
[OutputMap, Feature_Vector, coeffArray] = analyzeADQ1(im1);
imagesc(OutputMap);
title('JPG');
subplot(2,2,4);
im2='demo.png'
[OutputMap2, Feature_Vector, coeffArray] = analyzeADQ1(im2);
imagesc(OutputMap2);
title('PNG');