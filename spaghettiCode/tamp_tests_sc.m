% function [] = tamp_tests_sc(path)

path = 'C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-forged\dev_0250.tif';
im1=path;
imka=imread(im1);
subplot(4,4,1);
imagesc(CleanUpImage(im1));
title('Orig');

%% ADQ1
[OutputMap, ~, ~] = analyzeADQ1(im1);
subplot(4,4,2);
imagesc(OutputMap);
title('ADQ1');

%% ADQ2
try 
    OutputMap2 = analyzeADQ2(im1);
    subplot(4,4,3);
    imagesc(OutputMap2);
    title('ADQ2');
catch
    %do nothing
end
%% CFA1
OutputMap3 = analyzeCFA1(im1);
subplot(4,4,4);
imagesc(OutputMap3);
title('CFA1');

%% CFA2
OutputMap4 = analyzeCFA2(im1);
subplot(4,4,5);
imagesc(OutputMap4);
title('CFA2');

%% DCT
OutputMap5 = analyzeDCT(im1);
subplot(4,4,6);
imshow(OutputMap5);
title('DCT');

%% ELA
OutputMap6 = analyzeELA(im1);
subplot(4,4,7);
imagesc(OutputMap6);
title('ELA');

%% NOI2
try
OutputMap7 = analyzeNOI2(im1);
subplot(4,4,8);
imagesc(OutputMap7);
title('NOI2');
catch
    %do nothing
end
%% NADQ
try
OutputMap8 = analyzeNADQ(im1);
subplot(4,4,9);
imagesc(OutputMap8);
title('NADQ');
catch
    %do nothing
end
%% NOI1
try
OutputMap9 = analyzeNOI1(im1);
subplot(4,4,10);
imagesc(OutputMap9);
title('NOI1');
catch
    %do nothing
end

%% CAGI
try
[ Result_CAGI,Result_Inv_CAGI ] = CAGI(im1);
subplot(4,4,11);
imagesc(Result_CAGI);
title('cagi normal');
subplot(4,4,12);
imagesc(Result_Inv_CAGI);
title('inv_cagi');
catch
    %do nothing
end

%% BLK
OutputMap10 = analyzeBLK(im1);
subplot(4,4,13);
imagesc(OutputMap10);
title('BLK');

%% NOI4
OutputMap11 = analyzeNOI4(im1);
subplot(4,4,14);
imagesc(OutputMap11);
title('NOI4');


%% ghost
OutputMap12 = analyze(im1);
subplot(4,4,15);
imagesc(OutputMap12{1});
title('GHO');