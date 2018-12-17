% Copyright (C) 2016 Markos Zampoglou
% Information Technologies Institute, Centre for Research and Technology Hellas
% 6th Km Harilaou-Thermis, Thessaloniki 57001, Greece

close all; clear all;
im1='C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-forged/dev_0001.jpg'
[OutputMap, Feature_Vector, coeffArray] = analyze(im1);
imagesc(OutputMap);
