

close all; clear all;
im1='C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-forged/dev_0001.jpg'
[OutputMap] = analyze(im1);
imagesc(OutputMap);
title('JPG');
figure;
im2='demo.png'
[OutputMap] = analyze(im2);
imagesc(OutputMap);
title('PNG');