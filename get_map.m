function [finalImage,met] = get_map(path)

    %% Some definitions
    DEST_FOLDER='DEMO_RESULTS';

    %% Algorithms chains
    jpegList = {'ADQ2|ADQ1','CAGI','NOI1','GHO1','InvCAGI'};
    tifList = {'BLK','ELA','ADQ1','CFA2','CAGIs','CAGI','CFA1','InvCAGIx','CAGIx','CFA1'};
    
    %% Select algorithms set according to the file type
    [~,filename,extension] = fileparts(path);
    if (strcmp(extension,'.jpg') || strcmp(extension,'.jpeg'))
        % This is a JPEG file run set of algorithms for it
        listOfAlrorithms = jpegList;
    else
        % This is a TIF file run set of algorithms for it
        listOfAlrorithms = tifList;
    end
    
    %% Run analysis
    [~,algorithmsSize] = size(listOfAlrorithms);
    matchValue = false;
    for j=1:algorithmsSize
        
        % Run next algorithms and evaluate the result
        method = listOfAlrorithms{j};
        im = runAlgorithm(method,path);
        matchValue = evaluateMap(im);
        
        % Check the result of the evaluation
        if(matchValue == true)
           met = method;
           finalImage = im;
           break;
        end
    end
    
    %% If all methods failed
    if (matchValue == false)
        finalImage = im;
        met = 'lil';
        fprintf('Everything FAILED\n');
    end
    
    %% Write generated image to the destination folder
    out_filepath = sprintf('%s\\%s_map%s',DEST_FOLDER,filename,'.bmp');
    imwrite(finalImage,out_filepath);
end
    