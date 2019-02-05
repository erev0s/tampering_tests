# Tampering Detection in JPG and TIF images
This is code used during a competition of Multimedia Data Security course in University of Trento. We received the higher mark for our results (31). There are minor edits to the algorithms based on some problems we faced. The interesting part of the code is the way it evaluates if the output of each algorith is a proper results or not, which can be found  [here][1]. Important is also the editing of each results before the evaluation.

There is also a folder named spaghetti code with some testing cases and other parts not particularly useful. You can download some testing images [here][2]

To run the code please execute the function getmap(Path), where Path is the path of the image that we want to analyze.
The output as requested will be written in the Directory "DEMO_RESULTS".
* Note that for the correct use of the code it is mandatory to include the SUPPORT directory (Add Folders and Sub Folders)
* If you want to run the code on multiple images you can find the script tests.m in the SUPPORT directory;
* in this case you need to specify: the path to the dir containing the forged images, the one containing the true forgery maps, and the number_of_images that you want to analyze  
 
### The algorithms used are from https://github.com/MKLab-ITI/image-forensics/tree/master/matlab_toolbox/Algorithms


[1]: https://github.com/erev0s/tampering_tests/blob/master/SUPPORT/evaluateMap.m
[2]: https://drive.google.com/file/d/1kIV_W7tZf3JdMP2jqCMY7loqlh2pY13d/view?usp=sharing
