clc;clear;
path = 'C:\Users\erev\Documents\MATLAB\dev-dataset\test\';
files = dir(fullfile(path, '*.*'));
L = length(files);
cor=0;
lim = 0.8389;
words = 'Map is NOT the same as the given one ! ';

for i=3:L
    file=files(i).name;
    filepath = fullfile( path, file );
    correctpath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-maps\', strcat(file(1:end-3),'bmp'));
    b = imread(correctpath);
    
    
    %% to keep it in mind
    % mask = imfill(mask, 'holes');
    %     mask = imcomplement(mask)
    
    try
        [OutputMap] = analyzeADQ2(filepath);
        OutputMap=imbinarize(OutputMap);
        OutputMap=(imresize(OutputMap,[1500 2000]));
        OutputMap = imclose(bwareafilt(OutputMap,1), ones(20));
        OutputMap = imfill(OutputMap, 'holes');
        
        [OutputMap2, ~, ~] = analyzeADQ1(filepath);
        OutputMap2=imbinarize(OutputMap2);
        OutputMap2=(imresize(OutputMap2,[1500 2000]));
        OutputMap2 = imclose(bwareafilt(OutputMap2,1), ones(20));
        OutputMap2 = imfill(OutputMap2, 'holes');
        
        C = imfuse(OutputMap,OutputMap2);
        C=imbinarize(rgb2gray(C));
        C=imfill(C, 'holes');
        
        %%check perimeter
        stats = regionprops(C,'Perimeter');
        if stats(1).Perimeter < 5000
            %just keep going
        else
            error('fae skata');
        end
        
        
        savepath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\me\', strcat(file(1:end-3),'bmp'));
        imwrite(C,savepath);
        c = corr2(C,b);
        if (c>lim)
            cor = cor + 1;
            fprintf('coming from  - >  %s -- method ADQ1-2 \n\n',file);
        else
            fprintf('%s - >  %s -- method ADQ1-2 \n',words,file);
        end
        
    catch
        try
            
            [OutputMap] = analyzeDCT(filepath);
            OutputMap=imbinarize(OutputMap);
            OutputMap=(imresize(OutputMap,[1500 2000]));
            OutputMap = imclose(bwareafilt(OutputMap,1), ones(20));
            OutputMap = imfill(OutputMap, 'holes');
            
            
            [OutputMap2, Result_Inv_CAGI] = CAGI(filepath);
            OutputMap2=imbinarize(OutputMap2);
            OutputMap2=(imresize(OutputMap2,[1500 2000]));
            OutputMap2 = imclose(bwareafilt(OutputMap2,1), ones(20));
            OutputMap2 = imfill(OutputMap2, 'holes');
            
            C = imfuse(OutputMap,OutputMap2);
            C=imbinarize(rgb2gray(C));
            C=imfill(C, 'holes');
            
            %%check perimeter
            stats = regionprops(C,'Perimeter');
            if stats(1).Perimeter < 5000
                %just keep going
            else
                error('fae skata');
            end
            
            savepath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\me\', strcat(file(1:end-3),'bmp'));
            imwrite(C,savepath);
            c = corr2(C,b);
            if (c>lim)
                cor = cor + 1;
                fprintf('coming from  - >  %s -- method DCT CAGI \n\n',file);
            else
                fprintf('%s - >  %s -- method DCT-CAGI\n',words,file);
            end
        catch
            try
                [OutputMap] = analyzeADQ1(filepath);
                OutputMap=imbinarize(OutputMap);
                OutputMap=(imresize(OutputMap,[1500 2000]));
                OutputMap = imclose(bwareafilt(OutputMap,1), ones(20));
                OutputMap = imfill(OutputMap, 'holes');
                
                [OutputMap2, Result_Inv_CAGI] = CAGI(filepath);
                OutputMap2=imbinarize(OutputMap2);
                OutputMap2=(imresize(OutputMap2,[1500 2000]));
                OutputMap2 = imclose(bwareafilt(OutputMap2,1), ones(20));
                OutputMap2 = imfill(OutputMap2, 'holes');
                
                C = imfuse(OutputMap,OutputMap2);
                C=imbinarize(rgb2gray(C));
                C=imfill(C, 'holes');
                
                %%check perimeter
                stats = regionprops(C,'Perimeter');
                if stats(1).Perimeter < 5000
                    %just keep going
                else
                    error('fae skata');
                end
                
                savepath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\me\', strcat(file(1:end-3),'bmp'));
                imwrite(C,savepath);
                c = corr2(C,b);
                if (c>lim)
                    cor = cor + 1;
                    fprintf('coming from  - >  %s -- method ADQ1 CAGI \n\n',file);
                else
                    fprintf('%s - >  %s  -- method ADQ1 cAGI\n',words,file);
                end
            catch
                try
                    [OutputMap, Result_Inv_CAGI] = CAGI(filepath);
                    OutputMap=imbinarize(OutputMap);
                    OutputMap=(imresize(OutputMap,[1500 2000]));
                    OutputMap = imclose(bwareafilt(OutputMap,1), ones(20));
                    OutputMap = imfill(OutputMap, 'holes');
                    C=OutputMap;
                    %                     C=imbinarize(im2uint8(C));
                    %                     C=imfill(C, 'holes');
                    
                    %%check perimeter
                    stats = regionprops(C,'Perimeter');
                    if stats(1).Perimeter < 5000
                        %just keep going
                    else
                        error('fae skata');
                    end
                    
                    savepath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\me\', strcat(file(1:end-3),'bmp'));
                    imwrite(C,savepath);
                    c = corr2(C,b);
                    if (c>lim)
                        cor = cor + 1;
                        fprintf('coming from  - >  %s -- method CAGI \n\n',file);
                    else
                        fprintf('%s - >  %s  -- method CAGI\n',words,file);
                    end
                    
                catch
                    try
                        [OutputMap] = analyzeGHO(filepath);
                        OutputMap=imbinarize(OutputMap{1});
                        OutputMap=(imresize(OutputMap,[1500 2000]));
                        OutputMap = imclose(bwareafilt(OutputMap,1), ones(20));
                        OutputMap = imfill(OutputMap, 'holes');
                        C=OutputMap;
                        C=imbinarize(im2uint8(C));
                        C=imfill(C, 'holes');
                        
                        %%check perimeter
                        stats = regionprops(C,'Perimeter');
                        if stats(1).Perimeter < 5000
                            %just keep going
                        else
                            error('fae skata');
                        end
                        
                        savepath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\me\', strcat(file(1:end-3),'bmp'));
                        imwrite(C,savepath);
                        c = corr2(C,b);
                        if (c>lim)
                            cor = cor + 1;
                            fprintf('coming from  - >  %s -- method GHO \n\n',file);
                        else
                            fprintf('%s - >  %s  -- method GHO\n',words,file);
                        end
                    catch
                        [OutputMap] = analyzeCFA1(filepath);
                        OutputMap=imbinarize(OutputMap);
                        OutputMap=(imresize(OutputMap,[1500 2000]));
                        OutputMap = imclose(bwareafilt(OutputMap,1), ones(20));
                        OutputMap = imfill(OutputMap, 'holes');
                        C=OutputMap;
                        C=imbinarize(im2uint8(C));
                        C=imfill(C, 'holes');
                        
                        %%check perimeter
                        stats = regionprops(C,'Perimeter');
                        if stats(1).Perimeter < 5000 && getWhitePercent(C) > 10
                            %just keep going
                        else
                            fprintf('WE NEED TO FIND SOMETHING DIFFERENT HERE - CFA1 FAILED\n');
                        end
                        
                        savepath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\me\', strcat(file(1:end-3),'bmp'));
                        imwrite(C,savepath);
                        c = corr2(C,b);
                        if (c>lim)
                            cor = cor + 1;
                            fprintf('coming from  - >  %s -- method CFA1 \n\n',file);
                        else
                            fprintf('%s - >  %s  -- method CFA1\n',words,file);
                        end
                    end
                end
            end
        end
        
        
        
    end
    
end


fprintf('Got the correct maps on %d / %d \n',cor,L-2);






