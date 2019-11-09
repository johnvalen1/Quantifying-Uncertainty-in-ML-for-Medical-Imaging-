import glob
import cv2
import fnmatch
import numpy as np
#import CNN_model

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

def select_training_images(n,p):
    '''
    Creates a list of randomly selected images (each element has name of the form "*class1.png" or
    "*class0.png" and there are n images with proportion p of them cancerous)
    '''
    num_cancer = int(n*p)
    num_healthy = int(n*(1-p))
    #num_cancer + num_healthy = n
    np.random.seed(0)
    randomly_selected_cancer_images = list(np.random.choice(classOne, num_cancer))
    np.random.seed(0)
    randomly_selected_healthy_images = list(np.random.choice(classZero, num_healthy))

    training_set = randomly_selected_cancer_images + randomly_selected_healthy_images
    return training_set


def process_training_images_and_assign_labels(training_set):
    '''
    Returns two arrays:
        processed_x is an array of resized images (numpy arrays) respecting the
        given proportion p (i.e. imbalance scheme)
        y is an array of labels (0 or 1)
        It resizes images to 50x50x3 (RGB channel, not all images are in this layout)
        It normalizes the x-image pixel values
    '''
    height = 50
    width = 50
    channels = 3
    x = []
    y = []
    for img in training_set:
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
    processed_x = x.astype(np.float32)
    processed_x /= 255.
    return processed_x,y


def select_test_images(training_images, p = 0.5):
    '''
    Given the training set, this function will randomly select a test set of size k according to
    a train-test split of 90-10 such that NONE of the images chosen are in the training set. The default proportion is 0.5
    so that the test set is balanced.
    '''
    test_size = int(len(training_images)/0.9) - len(training_images)
    num_cancer_test = int(test_size*p) #how many cancer images in the test set
    num_healthy_test = int(test_size*(1-p)) #how many healthy images in the test set
    #num_cancer + num_healthy = k
    all_images = set(imagePatches)
    training_data = set(training_images)
    non_training_data = all_images - training_data #data without the training set
    classZero_test = fnmatch.filter(imagePatches, patternZero) #all healthy images in this set
    classOne_test = fnmatch.filter(imagePatches, patternOne) #all cancer images in this set

    np.random.seed(0)
    randomly_selected_test_cancer_images = list(np.random.choice(classOne_test, num_cancer_test))
    np.random.seed(0)
    randomly_selected_test_healthy_images = list(np.random.choice(classZero_test, num_healthy_test))
    test_set = randomly_selected_test_cancer_images + randomly_selected_test_healthy_images
    return test_set

def process_test_images(test_images):
    '''
    Takes in the given test_images list which consists of image names in string form
    and converts them to numpy arrays such that the classifier can make predictions on them.
    '''

    height = 50
    width = 50
    channels = 3
    x=[]

    for img in test_images:
        full_size_image = cv2.imread(img)
        image = (cv2.resize(full_size_image, (width,height), interpolation=cv2.INTER_CUBIC))
        x.append(image)
    x = np.array(x)
    processed_test_image = x.astype(np.float32)
    processed_test_image /= 255.
    return processed_test_image


if __name__=="__main__":

    # for sample_size in sample_sizes:
    #     for prop in proportions:
    #         X, Y = select_training_images(sample_size, prop)
    #
    #         #fit the model
    #
    #         #acquire accuracy metrics
    #
    #         #save results in a CSV, row-by-row
