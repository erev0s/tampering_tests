function OutputMap = analyzeNOI1( imPath )
    BlockSize=8;
    
    im=CleanUpImage(imPath);
    
    OutputMap = GetNoiseMap(im, BlockSize);
end