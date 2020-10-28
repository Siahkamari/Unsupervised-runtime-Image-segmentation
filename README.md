# Unsupervised Runtime Image Segmentation


Provided is a matlab code that does image segmentation and edge detection given a rgb image. 


## Results
We tested our algorithm on [BSD500 dataset](https://www2.eecs.berkeley.edu/Research/Projects/CS/vision/bsds/). See our resulting segmentations in "results" folder.


## Demonstrations
Bellow you can see the iterations of our algorithms on some images!
![Alt Text](results/gifs/out.gif)
![Alt Text](results/gifs/out2.gif)
![Alt Text](results/gifs/out3.gif)




## Explanation
The algorithm basically finds enclosed segments with similar colors. The algorithm initializes by a simple segmentation. Then it deformes the boundry of the segmentation in a greedy manner (Similar to K means).
