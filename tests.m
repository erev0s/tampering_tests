clear;
%% some constants here
path = 'C:\Users\erev\Documents\MATLAB\dev-dataset\test\';
outputpath = 'C:\Users\erev\Documents\MATLAB\dev-dataset\me\';
propermaps = 'C:\Users\erev\Documents\MATLAB\dev-dataset\dev-dataset-maps\';
limit = 0.8384;
jpegs=0;
suc=0;

Faddup = 0;
Faddupov = 0;
start_time = cputime;

dirInfo = dir(path);
files = {dirInfo(~[dirInfo.isdir]).name};
[~, L] = size(files);



%% actual checking
for i=1:L
    file=files{i};
    filepath = fullfile(path, file );
    %Get the best map for that image
%     if strcat(file(end-3:end)) == '.jpg' %%checking for tifs now
%         continue;
%     end
    jpegs= jpegs+1;
    [im,success,met] = get_map(filepath);
    %Compare to the actual tampering map. THIS WILL NOT BE PART OF THE
    %FINAL CODE
    
    correctpath = fullfile( propermaps, strcat(file(1:end-3),'bmp'));
    b = imread(correctpath);
    
    [F] = f_measure(double(im),double(b));
    correlation = corr2(im,b);
    Faddup = F + Faddup;
    
    %% add the FM of complementary method just to check results
    imcomp = imcomplement(im);
    Fimcomp = f_measure(double(imcomp),double(b));
    
    %% printing
    if F > limit || Fimcomp > limit
        suc=suc+1;
        fprintf('SUCCESS: %s with method -> %s and COR = %2.4f and FMeasure = %2.4f and CompFM = %2.4f \n \n',file,met,correlation,F,Fimcomp);
    else
        fprintf('FAILURE: %s with method -> %s and COR = %2.4f and FMeasure = %2.4f and CompFM = %2.4f \n \n',file,met,correlation,F,Fimcomp);
    end
    savepath = fullfile( outputpath, strcat(file(1:end-3),'bmp'));
    imwrite(im,savepath);


%% check best FM between normal and complementary image
if F>Fimcomp
    Faddupov = Faddupov + F;
else
    Faddupov = Faddupov + Fimcomp;
end
end
stop_time = cputime;
fprintf('Average F Measure = %2.4f and FMov = %2.4f ||| OVERALL SUCCESS in %d / %d  in %0.5f sec\n \n',Faddup/jpegs,Faddupov/jpegs,suc,jpegs,abs( start_time - stop_time));
 
 
