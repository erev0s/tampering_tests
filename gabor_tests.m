path = 'C:\Users\erev\Documents\MATLAB\dev-dataset\test\dev_0001.jpg';
A = rgb2gray(imread(path));

wavelength = 10;
orientation = [0 45];
g = gabor(wavelength,orientation);

outMag = imgaborfilt(A,g);

outSize = size(outMag);
outMag = reshape(outMag,[outSize(1:2),1,outSize(3)]);
figure, montage(outMag,'DisplayRange',[]);
title('Montage of gabor magnitude output images.');