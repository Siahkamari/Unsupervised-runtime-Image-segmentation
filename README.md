# Unsupervised-runtime-Image-segmentation


Provided is a matlab code that does image segmentation and edge detection based on a single image. It basically finds enclosed segments with similar colors. 


The algorithm initializes by a simple segmentation. Then it deformes the boundry of the segmentation in a greedy manner (Similar to K means).


The segmentation data of @InProceedings{MartinFTM01,
  author = {D. Martin and C. Fowlkes and D. Tal and J. Malik},
  title = {A Database of Human Segmented Natural Images and its
           Application to Evaluating Segmentation Algorithms and
           Measuring Ecological Statistics},
  booktitle = {Proc. 8th Int'l Conf. Computer Vision},
  year = {2001},
  month = {July},
  volume = {2},
  pages = {416--423}
}

is used for demonstration porposes and the corresponding output of algorithm is saved in the file "triplet_outputs"
