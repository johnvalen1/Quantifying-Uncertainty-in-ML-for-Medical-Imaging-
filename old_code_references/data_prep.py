import glob
import cv2
import fnmatch
import numpy as np
#import CNN_model

#this is a list with ALL images...
imagePatches = glob.glob("C:/Users/John/Desktop/Research Project/Binary Project/Breast Cancer Data/**/*.png", recursive=True)

patternZero = '*class0.png'
patternOne = '*class1.png'
TEST_SET_SIZE = 20000
#saves the image file location of all images with file name 'class0'.. from this we can access ALL
#images with label 0 == no cancer
classZero = fnmatch.filter(imagePatches, patternZero)
#saves the image file location of all images with file name 'class1'.. from this we can access ALL
#images with label 1 == cancer
classOne = fnmatch.filter(imagePatches, patternOne)

def create_test_set(test_set_size = TEST_SET_SIZE, p=0.5):
    '''
    Randomly selects n images with imbalance prop. p (by default 50-50 split),
    and removes them from the dataset.
    This function should be run first before selection of training data
    '''
    num_cancer = int(test_set_size*p)
    num_healthy = int(test_set_size*(1-p))
    test_cancer_images = list(np.random.choice(classOne, num_cancer))
    test_healthy_images = list(np.random.choice(classZero, num_healthy))
    return test_healthy_images, test_cancer_images

def get_test_set(test_set_size):
    '''
    Puts together the test healthy images and test cancer images into a single list
    comprising the test set: then this will be saved to a text file as a hold-out set.
    This is also shuffled.
    '''
    test_healthy_images = create_test_set(test_set_size)[0]
    test_cancer_images = create_test_set(test_set_size)[1]
    data_as_array = test_healthy_images + test_cancer_images
    shuffled_test_data = np.random.choice(data_as_array, len(data_as_array))
    return shuffled_test_data

def select_training_images(n,p):
    '''
    n = training set size
    Creates a list of randomly selected images once the 20,000 test images
    have been put aside (each element has name of the form "*class1.png" or
    "*class0.png" and there are n images with proportion p of them cancerous)
    Where n < 277,524 - 20,000 = 257,524
    '''
    num_cancer = int(n*p)
    num_healthy = int(n*(1-p))
    #num_cancer + num_healthy = n
    non_test_cancer_images = list(set(classOne) - set(create_test_set()[1]))
    training_cancer_images = list(np.random.choice(non_test_cancer_images, num_cancer))

    non_test_healthy_images = list(set(classZero) - set(create_test_set()[0]))
    training_healthy_images = list(np.random.choice(non_test_healthy_images, num_healthy))

    training_set = training_cancer_images + training_healthy_images
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



#if __name__=="__main__":


    # for sample_size in sample_sizes:
    #     for prop in proportions:
    #         X, Y = select_training_images(sample_size, prop)
    #
    #         #fit the model
    #
    #         #acquire accuracy metrics
    #
    #         #save results in a CSV, row-by-row
