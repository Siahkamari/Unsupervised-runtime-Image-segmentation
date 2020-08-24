# Unsupervised-runtime-Image-segmentation


Provided is a matlab code that does image segmentation and edge detection based on a single image. It basically finds enclosed segments with similar colors. 


The algorithm initializes by a simple segmentation. Then it deformes the boundry of the segmentation in a greedy manner (Similar to K means).


We used [https://www2.eecs.berkeley.edu/Research/Projects/CS/vision/bsds/](BSD500 dataset) for demonstration porposes and the corresponding output of our algorithm is saved in the file "triplet_outputs"


![Alt Text](https://media.giphy.com/media/vFKqnCdLPNOKc/giphy.gif)
