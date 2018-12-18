function [result] = evaluateMap(image)
 %%check perimeter
 resultStruct = regionprops(image,'Perimeter');
 permi = resultStruct(1).Perimeter;
 if(permi<5000) && getWhitePercent(image)>4 && getWhitePercent(image)<88
     result = true;
 else
     result = false;
 end
 