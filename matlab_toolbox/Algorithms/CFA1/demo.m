% The demo image is taken from the Columbia Uncompressed Image Splicing 
% Detection Evaluation Dataset
% Original image name: canonxt_kodakdcs330_sub_01.tif
% Dataset available at: 
% http://www.ee.columbia.edu/ln/dvmm/downloads/authsplcuncmp/

close all; clear all;
im1='C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-forged/dev_0009.tif';
OutputMap = analyze(im1);
imagesc(OutputMap);