               


path = 'C:\Users\erev\Documents\MATLAB\dev-dataset\test\';
cor=0;
lim = 0.8389;
words = 'Map is NOT the same as the given one ! ';
    file='dev_0026.jpg';
    filepath = fullfile( path, file );
    correctpath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-maps\', strcat(file(1:end-3),'bmp'));
    b = imread(correctpath);

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
            
            %             C = imfuse(OutputMap,OutputMap2);
            C = OutputMap + OutputMap2;
%             C=imbinarize(rgb2gray(C));
            C=imfill(C, 'holes');
            
            %% check perimeter (need better rules here)
            stats = regionprops(C,'Perimeter');
            if stats(1).Perimeter < 5000
                %just keep going
            else
                error('fae skata');
            end
            %                     C=imbinarize(im2uint8(C));
%                     C=imfill(C, 'holes');
            
%                 C=imbinarize(rgb2gray(C));
%                 C=imfill(C, 'holes');
                
                %%check perimeter
%                 stats = regionprops(C,'Perimeter');
%                 stats(1).Perimeter
%                 if stats(1).Perimeter < 5000
%                     %just keep going
%                 else
%                     error('fae skata');
%                 end
                
                savepath = fullfile( 'C:\Users\erev\Desktop\', strcat(file(1:end-3),'bmp'));
                imwrite(C,savepath);
                imwrite(OutputMap,'C:\Users\erev\Desktop\outputmap.bmp');
                imwrite(OutputMap2,'C:\Users\erev\Desktop\outputmap2.bmp');
                c = corr2(C,b);
                if (c>lim)
                    cor = cor + 1;
                else
                    fprintf('%s - >  %s  -- method ADQ1 cAGI\n',words,file);
                end