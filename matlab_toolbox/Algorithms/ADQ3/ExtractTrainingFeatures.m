clear all; close all;
%This script was used to generate the training set contained in
%TrainingFeature.mat
%
%BaseFolder is the path where all the training data are kept. It must
%include two subfolders, "Single" and "Double". "Single" must contain one
%subfolder per Quality (i.e. "50","55",..."95"), while Double must contain
%one subfolder per Quality combination (i.e. ("50_55","50_60",...,"95_90")
%Inside each subfolder will be a number of 64x64 patches having undergone
%the corresponding JPEG compression history.
%
%The images were generated with CutTrainingImages and
%CompressTrainingImages as specified by the paper.

BaseFolder='/media/marzampoglou/New_NTFS_Volume/markzampoglou/ImageForensics/Datasets/FirstDigit/jpg/';
Qualities=50:5:95;
c1=2; c2=10; %skip the DC term and keep 9 coefficients
ncomp=1;
digitBinsToKeep=[2 5 7];

for Quality=Qualities
    SingleListTmp=dir([BaseFolder 'Single/' num2str(Quality) '/*.jpg']);
    SingleListTmp={SingleListTmp.name};
    SingleList{(Quality-50)/5+1}=strcat([BaseFolder 'Single/' num2str(Quality) '/'], SingleListTmp);
    
    DoubleList{(Quality-50)/5+1}={};
    DoubleListDir=dir([BaseFolder 'Double/*_' num2str(Quality) '/']);
    DoubleListDir={DoubleListDir.name};
    for DoubleDir=1:length(DoubleListDir)
        DoubleListTmp=dir([BaseFolder 'Double/' DoubleListDir{DoubleDir} '/*.jpg']);
        DoubleListTmp={DoubleListTmp.name};
        DoubleListTmp=strcat([BaseFolder 'Double/' DoubleListDir{DoubleDir} '/'], DoubleListTmp);
        DoubleList{(Quality-50)/5+1}=[DoubleList{(Quality-50)/5+1} DoubleListTmp];
    end
    SingleFeatures{(Quality-50)/5+1}=zeros(length(SingleList{(Quality-50)/5+1}),(c2-c1+1)*length(digitBinsToKeep));
    for SingleItem=1:length(SingleList{(Quality-50)/5+1})
        im=jpeg_read(SingleList{(Quality-50)/5+1}{SingleItem});
        SingleFeatures{(Quality-50)/5+1}(SingleItem,:)=ExtractFeatures(im, c1, c2, ncomp, digitBinsToKeep);        
    end
    DoubleFeatures{(Quality-50)/5+1}=zeros(length(DoubleList{(Quality-50)/5+1}),(c2-c1+1)*length(digitBinsToKeep));
    for DoubleItem=1:length(DoubleList{(Quality-50)/5+1})
        im=jpeg_read(DoubleList{(Quality-50)/5+1}{DoubleItem});
        DoubleFeatures{(Quality-50)/5+1}(DoubleItem,:)=ExtractFeatures(im, c1, c2, ncomp, digitBinsToKeep);
    end
    disp(Quality);
end

save('TrainingFeature.mat','SingleFeatures','DoubleFeatures','SingleList','DoubleList');