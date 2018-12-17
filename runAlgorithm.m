function [binaryIm] = runAlgorithm(alg,path)
% try
OutputMap2 = zeros(1500,2000);
duelMode = false;
invcagi=0;
switch(alg)
    case 'ADQ1'
        [OutputMap1, ~, ~] = analyzeADQ1(path);
    case 'CFA1'
        [OutputMap1] = analyzeCFA1(path);
    case 'DCT'
        [OutputMap1] = analyzeDCT(path);
    case 'NADQ'
        OutputMap1 = analyzeNADQ(path);
    case 'NOI1'
        OutputMap1 = analyzeNOI1(path);
    case 'GHO'
        [OutputMap1] = analyzeGHO(path);
    case 'ADQ2|ADQ1'
        duelMode = true;
        [OutputMap1] = analyzeADQ2(path);
        [OutputMap2, ~, ~] = analyzeADQ1(path);
    case 'DCT|CAGI'
        duelMode = true;
        [OutputMap1] = analyzeDCT(path);
        [OutputMap2, ~] = CAGI(path);
    case 'ADQ1|CAGI'
        duelMode = true;
        [OutputMap1, ~, ~] = analyzeADQ1(path);
        [OutputMap2, ~] = CAGI(path);
    case 'InvCAGI'
        [~,OutputMap1 ] = CAGI(path);
        invcagi = 1;
    case 'CAGI'
        [OutputMap1,~] = CAGI(path);
    otherwise
        [OutputMap1] = analyzeDCT(path);
end



if invcagi == 1
    binaryIm = OutputMap1;
    binaryIm=imbinarize(im2uint8(binaryIm));
    binaryIm = imcomplement(binaryIm);
    binaryIm=imfill(binaryIm, 'holes');
else
    OutputMap1=imbinarize(OutputMap1);
    OutputMap1=(imresize(OutputMap1,[1500 2000]));
    OutputMap1 = imclose(bwareafilt(OutputMap1,1), ones(20));
    OutputMap1 = imfill(OutputMap1, 'holes');
    
    binaryIm = OutputMap1;
    binaryIm=imbinarize(im2uint8(binaryIm));
    binaryIm=imfill(binaryIm, 'holes');
end
if(duelMode == true)
    OutputMap2=imbinarize(OutputMap2);
    OutputMap2=(imresize(OutputMap2,[1500 2000]));
    OutputMap2 = imclose(bwareafilt(OutputMap2,1), ones(20));
    OutputMap2 = imfill(OutputMap2, 'holes');
    
    binaryIm = imfuse(OutputMap1,OutputMap2);
    binaryIm=imbinarize(rgb2gray(binaryIm));
    binaryIm=imfill(binaryIm, 'holes');    
end


%
% catch
%     fprintf('in RUN ALGORITHM it went into the CATCH %s', alg);
%     %     error('runalgorithm could not get binaryIm');
%     binaryIm = zeros(1500,2000);
% end
