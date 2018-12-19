clear;
path = 'C:\Users\erev\Documents\MATLAB\dev-dataset\test\';
outputpath = 'C:\Users\erev\Documents\MATLAB\dev-dataset\me\';
propermaps = 'C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-maps\';
jpegs=0;
suc=0;
files = dir(fullfile(path, '*.*'));
L = length(files);
Faddup = 0;
for i=3:L
    file=files(i).name;
    filepath = fullfile(path, file );
    %Get the best map for that image
    if strcat(file(end-3:end)) == '.jpg' %%checking for tifs now
        continue;
    end
    jpegs= jpegs+1;
    [im,success,met] = get_map(filepath);
    %Compare to the actual tampering map. THIS WILL NOT BE PART OF THE
    %FINAL CODE
    
    correctpath = fullfile( propermaps, strcat(file(1:end-3),'bmp'));
    b = imread(correctpath);
    
    [F] = f_measure(double(im),double(b));
    correlation = corr2(im,b);
    Faddup = F + Faddup;
    if F > 0.8383
        suc=suc+1;
        fprintf('SUCCESS: %s with method -> %s and COR = %2.4f and FMeasure = %2.4f \n \n',file,met,correlation,F);
    else
        fprintf('FAILURE: %s with method -> %s and COR = %2.4f and FMeasure = %2.4f \n \n',file,met,correlation,F);
    end
    savepath = fullfile( outputpath, strcat(file(1:end-3),'bmp'));
    imwrite(im,savepath);
end
allfiles = dir(fullfile(outputpath));
Li = length(allfiles);
fprintf('Average F Measure = %2.4f , SUCCESS in %d / %d \n \n',Faddup/jpegs,suc,jpegs);
 
 