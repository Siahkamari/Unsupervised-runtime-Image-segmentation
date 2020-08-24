# Unsupervised Runtime Image Segmentation


Provided is a matlab code that does image segmentation and edge detection given a rgb image. 


## Results
We used [BSD500 dataset](https://www2.eecs.berkeley.edu/Research/Projects/CS/vision/bsds/) for demonstration porposes and the corresponding output of our algorithm is saved in the file "triplet_outputs"


## Demonstrations
Bellow you can see the iterations of our algorithms on some images!
![Alt Text](out.gif)



## Explanation
The algorithm basically finds enclosed segments with similar colors. The algorithm initializes by a simple segmentation. Then it deformes the boundry of the segmentation in a greedy manner (Similar to K means).
