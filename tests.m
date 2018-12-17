clear;
path = 'C:\Users\erev\Documents\MATLAB\dev-dataset\test\';
files = dir(fullfile(path, '*.*'));
L = length(files);
Faddup = 0;
for i=3:L
    file=files(i).name;
    filepath = fullfile(path, file );
    %Get the best map for that image
    if strcat(file(end-3:end)) == '.tif'
        continue;
    end
    [im,success,met] = get_map(filepath);
    %Compare to the actual tampering map. THIS WILL NOT BE PART OF THE
    %FINAL CODE
    
    correctpath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-maps\', strcat(file(1:end-3),'bmp'));
    b = imread(correctpath);
    
    [F] = f_measure(double(im),double(b));
    correlation = corr2(im,b);
    Faddup = F + Faddup;
    fprintf('%s with method -> %s and COR = %2.4f and FMeasure = %2.4f \n \n',file,met,correlation,F);
    savepath = fullfile( 'C:\Users\erev\Documents\MATLAB\dev-dataset\me\', strcat(file(1:end-3),'bmp'));
    imwrite(im,savepath);
end
allfiles = dir(fullfile('C:\Users\erev\Documents\MATLAB\dev-dataset\me\'));
Li = length(allfiles);
fprintf('Average F Measure = %2.4f \n \n',Faddup/(Li-2));
 
 