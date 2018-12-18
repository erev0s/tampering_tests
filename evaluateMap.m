function [result] = evaluateMap(image)
 %%check perimeter
 resultStruct = regionprops(image,'Perimeter');
 try
     permi = resultStruct(1).Perimeter;
 catch
     permi = 1;%%so when in some methods you get 
               %%black output it will not throw an error
 end
 if(permi<5000) && getWhitePercent(image)>4 && getWhitePercent(image)<88
     result = true;
 else
     result = false;
 end
 