function [finalImage,success,met] = get_map(path)

%% LIST
% jpegList = {'ADQ2|ADQ1','CAGI','BLK','InvCAGIx'};
% jpegList = {'ADQ2|ADQ1','CAGI','InvCAGIx','NOI1'}; %72% without the bwarea filt in the complementary
jpegList = {'ADQ2|ADQ1','CAGI','InvCAGIx','NOI1','DCT|CAGI'};
% tifList = {'BLK','ADQ1','CAGI','InvCFA1','InvCAGIx','CFA2','NOI1','InvCFA1'};
tifList = {'BLK','ADQ1','CFA2','CAGIs','CAGI','InvCAGIx'};
success = true;

%% 
file = strcat('dev_',extractAfter(path,'dev_'));

    finalImage = imread(path);
    extension = extractAfter(file,'.');
    if(strcmp(extension,'jpg'))
        %% THIS IS JPEG FILE run set of algorithms for it
        listOfAlrorithms = jpegList;
    else
        %% THIS IS TIF FILE run set of algorithms for it
        listOfAlrorithms = tifList;
    end
    
    [~,algorithmsSize] = size(listOfAlrorithms);
    valueFound = false;
    for j=1:algorithmsSize
        method = listOfAlrorithms{j};
        im = runAlgorithm(method,path);
%         fprintf('Method used is -> %s\n',method{1});
        % Check the result
        matchValue = evaluateMap(im);
        if(matchValue==true)
           valueFound = true;
           met = method;
           finalImage = im;
           break;
        end
    end
    if(valueFound==false)
        finalImage = im;
        met = 'lil';
        fprintf('Everything FAILED\n');
    end
    