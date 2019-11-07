import glob
import cv2
import fnmatch
import numpy as np
import CNN_model



#this is a list with ALL images...
imagePatches = glob.glob("C:/Users/John/Desktop/Research Project/Binary Project/Breast Cancer Data/**/*.png", recursive=True)

patternZero = '*class0.png'
patternOne = '*class1.png'
#saves the image file location of all images with file name 'class0'.. from this we can access ALL
#images with label 0 == no cancer
classZero = fnmatch.filter(imagePatches, patternZero)
#saves the image file location of all images with file name 'class1'.. from this we can access ALL
#images with label 1 == cancer
classOne = fnmatch.filter(imagePatches, patternOne)

def process_selected_images(n,p):
    '''
    Returns two arrays:
        x is an array of resized images respecting the given proportion (i.e. imbalance scheme)
        y is an array of labels
        0 <= lowerIndex <= upperIndex <= len(imagePatches) = 277,524
    '''
    height = 50
    width = 50
    channels = 3
    x = [] #list to store image data
    y = [] #list to store corresponding class
    
    num_cancer = int(n*p)
    num_healthy = int(n*(1-p))
    print(num_cancer, num_healthy)
    #num_cancer + num_healthy = n
     #for the same selection every time
    np.random.seed(0)
    randomly_selected_cancer_images = list(np.random.choice(classOne, num_cancer))
     #for the same selection every time
    np.random.seed(0)
    randomly_selected_healthy_images = list(np.random.choice(classZero, num_healthy))
    # random_images = np.random.choice(imagePatches, n, replace=False)#without replacement.
    random_images = randomly_selected_cancer_images + randomly_selected_healthy_images
    for img in random_images:
        full_size_image = cv2.imread(img)
        image = (cv2.resize(full_size_image, (width,height), interpolation=cv2.INTER_CUBIC))
        x.append(image)
        if img in classZero:
            y.append(0)
        elif img in classOne:
            y.append(1)
        else:
            return
    x = np.array(x)
    x = X.astype(np.float32)
    x /= 255.
    return x,y


if __name__=="__main__":
    #We can select the size of the training set based on indexing. Between m and n
    sample_sizes = [5000, 10000, 20000] #should be linearly scheduled?
    proportions = [0.01, 0.05, 0.1, 0.25, 0.5] #should be linearly scheduled?
    test_size = 0.15

    #now get the training and test data:
    from sklearn.model_selection import train_test_split

    for sample_size in sample_sizes:
        for prop in proportions:
            X, Y = process_selected_images(sample_size, prop)
            X_train, X_test, y_train, y_test = train_test_split(X,Y,test_size=test_size)
            #fit the model

            #acquire accuracy metrics
            
            #save results in a CSV, row-by-row
