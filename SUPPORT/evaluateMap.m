function [result] = evaluateMap(image)
 %%check perimeter
 resultStruct = regionprops(image,'Perimeter');
 try
     permi = resultStruct(1).Perimeter;
%     fprintf('Perimeter = %2.4f and white percentage = %2.4f \n',permi,getWhitePercent(image));
 catch
     permi = 1;%%so when in some methods you get 
               %%black output it will not throw an error
 end
 if(permi<5893) && getWhitePercent(image)>4 && getWhitePercent(image)<88
     result = true;
 else
     result = false;
 end
 