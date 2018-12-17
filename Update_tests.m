clear;
path = 'C:\Users\erev\Documents\MATLAB\dev-dataset\test\';
files = dir(fullfile(path, '*.*'));
L = length(files);
cor=0;
lim = 0.8389;
% words = 'Map is NOT the same as the given one ! ';
r=0;
for i=3:L
    file=files(i).name;
    filepath = fullfile( path, file );
    correctpath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-maps\', strcat(file(1:end-3),'bmp'));
    b = imread(correctpath);
    
    
    %% to keep it in mind
    % mask = imfill(mask, 'holes');
    %     mask = imcomplement(mask)
    %resize to be last
    
    if strcat(file(end-3:end)) == '.jpg'
        r = r+1;
        try
            %% ADQ1 | ADQ2
            [OutputMap] = analyzeADQ2(filepath);
            OutputMap=imbinarize(OutputMap);
            OutputMap = imclose(bwareafilt(OutputMap,1), ones(20));
            OutputMap = imfill(OutputMap, 'holes');
            OutputMap=(imresize(OutputMap,[1500 2000]));
            
            [OutputMap2, ~, ~] = analyzeADQ1(filepath);
            OutputMap2=imbinarize(OutputMap2);
            OutputMap2 = imclose(bwareafilt(OutputMap2,1), ones(20));
            OutputMap2 = imfill(OutputMap2, 'holes');
            OutputMap2=(imresize(OutputMap2,[1500 2000]));
            
            C = imfuse(OutputMap,OutputMap2);
            C=imbinarize(rgb2gray(C));
            C=imfill(C, 'holes');
            
            %% check perimeter (need better rules here)
            stats = regionprops(C,'Perimeter');
            if stats(1).Perimeter < 5000
                %just keep going
            else
                error('fae skata');
            end
            
            savepath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\me\', strcat(file(1:end-3),'bmp'));
            imwrite(C,savepath);
            c = corr2(C,b);
            [F,tp,fn,fp] = f_measure(b,C);
            if (c>lim)
                cor = cor + 1;
                fprintf('SUCCESS: File is  - >  %s and method ADQ1-2 with Cor = %2.4f and FM = %2.4f \n \n',file, c, F);
            else
                fprintf('FAILURE: File is  - >  %s and method ADQ1-2 with Cor = %2.4f and FM = %2.4f \n \n',file, c, F);
            end
            
        catch
            try
                %% CHECKING FOR THE INV CAGI IN COMPLEMENTARY MODE (15,19)
                [Result_CAGI,OutputMap ] = CAGI(filepath);
                OutputMap=imbinarize(OutputMap);
                OutputMap = imcomplement(OutputMap);
                OutputMap = imclose(bwareafilt(OutputMap,1), ones(20));
                OutputMap = imfill(OutputMap, 'holes');
                OutputMap=(imresize(OutputMap,[1500 2000]));
                
                C=OutputMap;
                %% check perimeter (need better rules here)
                stats = regionprops(C,'Perimeter');
                if stats(1).Perimeter < 5000
                    %just keep going
                else
                    error('fae skata');
                    
                end
                
                savepath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\me\', strcat(file(1:end-3),'bmp'));
                imwrite(C,savepath);
                c = corr2(C,b);
                [F,tp,fn,fp] = f_measure(b,C);
                if (c>lim)
                    cor = cor + 1;
                    fprintf('SUCCESS: File is  - >  %s and method INV CAGI with Cor = %2.4f and FM = %2.4f \n \n',file, c, F);
                else
                    fprintf('FAILURE: File is  - >  %s and method INV CAGI with Cor = %2.4f and FM = %2.4f \n \n',file, c, F);
                end
                
            catch
                try
                    %% CAGI
                    [OutputMap ,InvResult_CAGI] = CAGI(filepath);
                    OutputMap=imbinarize(OutputMap);
                    OutputMap = imclose(bwareafilt(OutputMap,1), ones(20));
                    OutputMap = imfill(OutputMap, 'holes');
                    OutputMap=(imresize(OutputMap,[1500 2000]));
                    
                    C=OutputMap;
                    %% check perimeter (need better rules here)
                    stats = regionprops(C,'Perimeter');
                    if stats(1).Perimeter < 5000
                        %just keep going
                    else
                        error('fae skata');
                        
                    end
                    
                    savepath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\me\', strcat(file(1:end-3),'bmp'));
                    imwrite(C,savepath);
                    c = corr2(C,b);
                    [F,tp,fn,fp] = f_measure(b,C);
                    if (c>lim)
                        cor = cor + 1;
                        fprintf('SUCCESS: File is  - >  %s and method CAGI with Cor = %2.4f and FM = %2.4f \n \n',file, c, F);
                    else
                        fprintf('FAILURE: File is  - >  %s and method CAGI with Cor = %2.4f and FM = %2.4f \n \n',file, c, F);
                    end
                    
                catch
                    fprintf('CAGI FAILED -- IMPLEMENT MORE | file %s \n', file);
                end
            end
            
        end
        
        %% HERE ITS IF THIS IS TIF FILE
    else
        %         fprintf('this must be a tif file === %s \n', file);
    end
    
end


fprintf('Got the correct maps on %d / %d \n',cor,r);






