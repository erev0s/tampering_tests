% function [] = tif_testing(path)
path = 'C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-forged\dev_0005.tif';
im1=path;
% subplot(2,3,1);
% imagesc(CleanUpImage(im1));
% title('Orig');

%% ADQ1
[OutputMap, ~, ~] = analyzeADQ1(im1);
% subplot(2,3,2);
% imagesc(OutputMap);
% title('ADQ1');
OutputMap=imbinarize(OutputMap);
OutputMap=(imresize(OutputMap,[1500 2000]));
%first try
OutputMap1 = imclose(bwareafilt(OutputMap,1), ones(20));
imwrite(OutputMap1,'C:\Users\erev\Desktop\check1.bmp');



% %% CFA1
% OutputMap3 = analyzeCFA1(im1);
% subplot(2,3,3);
% imagesc(OutputMap3);
% title('CFA1');
% 
% %% CFA2
% OutputMap4 = analyzeCFA2(im1);
% subplot(2,3,4);
% imagesc(OutputMap4);
% title('CFA2');
% 
% %% CAGI
% try
% [ Result_CAGI,Result_Inv_CAGI ] = CAGI(im1);
% subplot(2,3,5);
% imagesc(Result_CAGI);
% title('CAGI');
% 
% subplot(2,3,6);
% imagesc(Result_Inv_CAGI);
% title('InvCAGI');
% catch
%     %do nothing
% end

