function [] = tamp_tests(path)

im1=path;
imka=imread(im1);
subplot(3,4,1);
title('Orig');
imshow(CleanUpImage(im1));

% %% ADQ1
% [OutputMap, Feature_Vector, coeffArray] = analyzeADQ1(im1);
% subplot(3,4,2);
% title('ADQ1');
% imshow(OutputMap);
% 
% %% ADQ2
% try 
%     OutputMap2 = analyzeADQ2(im1);
% % J = imresize(OutputMap2,[1500 2000]);
%     subplot(3,4,3);
%     imshow(OutputMap2);
% catch
%     %do nothing
% end
% %% CFA1
% OutputMap3 = analyzeCFA1(im1);
% subplot(3,4,4);
% imshow(OutputMap3);
% 
% %% CFA2
% OutputMap4 = analyzeCFA2(im1);
% subplot(3,4,5);
% imshow(OutputMap4);
% 
% %% DCT
% OutputMap5 = analyzeDCT(im1);
% subplot(3,4,6);
% imshow(OutputMap5);
% 
% %% ELA
% OutputMap6 = analyzeELA(im1);
% subplot(3,4,7);
% imshow(OutputMap6);
% 
% %% NOI2
% try
% OutputMap7 = analyzeNOI2(im1);
% subplot(3,4,8);
% imshow(OutputMap7);
% catch
%     %do nothing
% end
% %% NADQ
% try
% OutputMap8 = analyzeNADQ(im1);
% subplot(3,4,9);
% imshow(OutputMap8);
% catch
%     %do nothing
% end
% %% NOI1
% try
% OutputMap9 = analyzeNOI1(im1);
% subplot(3,4,10);
% imshow(OutputMap9);
% catch
%     %do nothing
% end

% %% CAGI
% try
% [ Result_CAGI,Result_Inv_CAGI ] = CAGI(im1);
% subplot(3,4,11);
% imshow(imbinarize(Result_CAGI));
% subplot(3,4,12);
% imshow(imbinarize(Result_Inv_CAGI));
% catch
%     %do nothing
% end

%% CAGI

[ Result_CAGI,Result_Inv_CAGI ] = CAGI(im1);
subplot(3,4,11);
imshow(bwboundaries(imbinarize(Result_CAGI)));
subplot(3,4,12);
imshow(bwboundaries(imbinarize(Result_Inv_CAGI)));


