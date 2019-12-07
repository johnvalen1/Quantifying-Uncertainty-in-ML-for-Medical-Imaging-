# Breast-Cancer-Study
Binary breast cancer study

CNN_model.py : the CNN is created and set up.

data_prep.py : 
Defines the test set, and puts it aside.
Then it selects the training set as a function of n (size of training set) and p (proportion of cancer images to preserve in the training set). It also prepares the training and test data for the model.

save_samples.py :
Creates the test set as a .txt file to be held-out and accessed later.
There is a file called "training sets" within which there are n by k files. n = how many sample sizes (taken as 4), k = how many proportions p (also taken as 4). n by k is how many possible combinations are possible (so 16 combinations). Each of these 16 files defines a possible sample size/imbalance setup on which we train, and each possible setup contains m samples (m = 20 here), so that the training data is different each time we train (like shuffling it, but with new examples for training).

visualize.py just reads in a random image from the directory and lets you view it.

DOWNLOAD DATA
https://www.kaggle.com/paultimothymooney/chest-xray-pneumonia
