# Breast-Cancer-Study
Binary breast cancer study

CNN_model.py : the CNN is created and set up.

data_prep.py : the function process_selected_images(n,p) takes in n = size of sample (for example 10,000 images) and p = proportion of cancer images (for example if p = 0.05, then the selected sample has 0.05* 10,000 = 500 images of cancer and 9,500 images of healthy tissue). It returns x, y = the images, their labels (of which p% are 1's). This function also implicitly resizes the inputs (images) to 50x50x3 and normalizes the pixel values (min-max normalization) as this is beneficial when training neural nets.

save_samples.py : this script will create the samples of both training images (that the classifier will train on, for choices of sample size and imbalance) and the accompanying test set (by default balanced, and of a size appropriate to a 90-10 train test split).

visualize.py just reads in a random image from the directory and lets you view it.

