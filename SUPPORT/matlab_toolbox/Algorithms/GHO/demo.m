close all; clear all;
im1='C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-forged/dev_0011.tif'
OutputMap = analyze(im1);
for ii=1:length(OutputMap)
    imagesc(OutputMap{ii});
    pause;
end