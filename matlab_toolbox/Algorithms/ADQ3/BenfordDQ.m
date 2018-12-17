function [OutputMap]=BenfordDQ(im)   
    % This code implements the algorithm presented in
    % Amerini, Irene, Rudy Becarelli, Roberto Caldelli, and Andrea Del
    % Mastio. "Splicing forgeries localization through the use of first
    % digit features." In Information Forensics and Security (WIFS), 2014
    % IEEE International Workshop on, pp. 143-148. IEEE, 2014.   
    %
    % Copyright (C) 2016 Markos Zampoglou
    % Information Technologies Institute, Centre for Research and Technology Hellas
    % 6th Km Harilaou-Thermis, Thessaloniki 57001, Greece
    
    % Load the ten SVM models. The models have been pre-trained using
    % TrainSVM.m
    load('SVMs.mat');
    
    % Get the quality of the JPEG image, in order to select the
    % corresponding SVM model
    
    Quality=EstimateJPEGQuality(im);
    QualityInd=round((Quality-50)/5+1);
    if QualityInd>10
        QualityInd=10;
    elseif QualityInd<1
        QualityInd=1;
    end
    
    Qualities=50:5:95;
    c1=2; c2=10; %skip the DC term and keep 9 coefficients
    ncomp=1;
    digitBinsToKeep=[2 5 7];
    block=im;
    qtable = im.quant_tables{im.comp_info(ncomp).quant_tbl_no};
    YCoef=im.coef_arrays{ncomp};
    Step=8;
    BlockSize=64;
    OutputMap=[];
    
    if min(size(im.coef_arrays{1},1))<BlockSize
        %if image is too small, return a non-detection
        OutputMap=0;
        return
    end
    
    for X=1:Step:size(YCoef,1)
        if X+BlockSize-1<=size(YCoef,1)
            StartX=X;
        else
            StartX=size(YCoef,1)-BlockSize+1;
            X=size(YCoef,1);
        end
        for Y=1:Step:size(YCoef,2)
            if Y+BlockSize-1<=size(YCoef,2)
                StartY=Y;
            else
                StartY=size(YCoef,2)-BlockSize+1;
                Y=size(YCoef,2);
            end
            block.coef_arrays{ncomp}=YCoef(StartX:StartX+BlockSize-1,StartY:StartY+BlockSize-1,:);
            Feature=ExtractFeatures(block, c1, c2, ncomp, digitBinsToKeep);
            Feature=Feature./64;
            [Class, Dist] = svmclassify_dist(SVMStruct{QualityInd},Feature);
            OutputMap(ceil((StartX-1)/Step+1),ceil((StartY-1)/Step+1))=Dist;
        end
    end
    OutputMap=[repmat(OutputMap(1,:),ceil(BlockSize/2/Step),1);OutputMap];
    OutputMap=[repmat(OutputMap(:,1),1,ceil(BlockSize/2/Step)) OutputMap];
end
