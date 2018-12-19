function [binaryIm] = runAlgorithm(alg,path)
OutputMap2 = zeros(1500,2000);
duelMode = false;
complm=false;
isitcagis=false;
default = false;

switch(alg)
    case 'ADQ1'
        default = true;
        [OutputMap1, ~, ~] = analyzeADQ1(path);
    case 'ELA'
        default = true;
        [OutputMap1] = analyzeELA(path);
    case 'CFA1'
        default = true;
        [OutputMap1] = analyzeCFA1(path);
    case 'CFA2'
        default = true;
        [OutputMap1] = analyzeCFA2(path);
    case 'DCT'
        default = true;
        [OutputMap1] = analyzeDCT(path);
    case 'NADQ'
        default = true;
        OutputMap1 = analyzeNADQ(path);
    case 'NOI1'
        default = true;
        OutputMap1 = analyzeNOI1(path);
    case 'GHO1'
        default = true;
        OutputMap1 = analyzeGHO(path);
        OutputMap1 = OutputMap1{1}; % has many layers --- try more???
    case 'ADQ2|ADQ1'
        duelMode = true;
        default = true;
        [OutputMap1] = analyzeADQ2(path);
        [OutputMap2, ~, ~] = analyzeADQ1(path);
    case 'DCT|CAGI'
        duelMode = true;
        default = true;
        [OutputMap1] = analyzeDCT(path);
        try
            [OutputMap2, ~] = CAGI(path);
        catch
            OutputMap2 = zeros(1500,2000);
        end
    case 'ADQ1|CAGI'
        default = true;
        duelMode = true;
        [OutputMap1, ~, ~] = analyzeADQ1(path);
        try
            [OutputMap2, ~] = CAGI(path);
        catch
            OutputMap2 = zeros(1500,2000);
        end
    case 'InvCAGIx'
        try
            [~,OutputMap1 ] = CAGI(path);
            complm = true;
        catch
            isitcagis = true;
            OutputMap1 = zeros(1500,2000);
        end
    case 'CAGIx'
        try
            [OutputMap1,~] = CAGI(path);
            complm = true;
        catch
            isitcagis = true;
            OutputMap1 = zeros(1500,2000);
        end
    case 'CAGI'
        try
            default = true;
            [OutputMap1,~] = CAGI(path);
        catch
            isitcagis = true;
            OutputMap1 = zeros(1500,2000);
        end
    case 'CAGIs'
        try
            [OutputMap1,~] = CAGI(path);
            isitcagis = true;
        catch
            isitcagis = true;
            OutputMap1 = zeros(1500,2000);
        end
    case 'BLK'
        default = true;
        [OutputMap1] = analyzeBLK(path);
    case 'InvCFA1'
        [OutputMap1] = analyzeCFA1(path);
        complm = true;
    otherwise
        default = true;
        [OutputMap1] = analyzeDCT(path);
        fprintf('METHOD NOT FOUND - RESORTING TO DCT \n');
end

%% if default processing happens
if default == true
    OutputMap1=imbinarize(OutputMap1);
    OutputMap1 = imclose(bwareafilt(OutputMap1,1), ones(20));
    OutputMap1 = imfill(OutputMap1, 'holes');
    OutputMap1=(imresize(OutputMap1,[1500 2000]));
    
    binaryIm = OutputMap1;
    binaryIm=imbinarize(im2uint8(binaryIm));
    binaryIm=imfill(binaryIm, 'holes');
end
%% if we need the complementary
if complm == true
    OutputMap1=imbinarize(im2uint8(OutputMap1));
    OutputMap1 = imcomplement(OutputMap1);
    OutputMap1 = imclose(bwareafilt(OutputMap1,1), ones(20)); %% ADDED THE BWAREAFILT HERE AS WELL
    OutputMap1=imfill(OutputMap1, 'holes');
    binaryIm=(imresize(OutputMap1,[1500 2000]));% cagi does not need it but others do
end
%% if its cagi method and we need to get the higher values
if isitcagis == true
    OutputMap1=imbinarize(im2uint8(OutputMap1),0.42);
    OutputMap1 = imclose(bwareafilt(OutputMap1,1), ones(20)); %% ADDED THE BWAREAFILT HERE AS WELL
    OutputMap1=imfill(OutputMap1, 'holes');
    binaryIm=(imresize(OutputMap1,[1500 2000]));% cagi does not need it but others do
end
%% if we gonna add them up
if duelMode == true
    OutputMap2=imbinarize(OutputMap2);
    OutputMap2 = imclose(bwareafilt(OutputMap2,1), ones(20));
    OutputMap2 = imfill(OutputMap2, 'holes');
    OutputMap2=(imresize(OutputMap2,[1500 2000]));
    
    binaryIm = OutputMap1 + OutputMap2;      %add the areas 3% increase
    binaryIm=imbinarize(im2uint8(binaryIm)); % needs to be checked with bigger dataset
    %     binaryIm = imfuse(OutputMap1,OutputMap2);
    %     binaryIm=imbinarize(rgb2gray(binaryIm));
    binaryIm=imfill(binaryIm, 'holes');
end


