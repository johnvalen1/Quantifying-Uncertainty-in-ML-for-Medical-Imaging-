import torch
import os
import matplotlib.pyplot as plt
import cv2 as cv
import numpy as np

imsource = "C:/Users/John/Desktop/Research Project/Binary Project/Breast Cancer Data/"

#grab a random patient
patient_number = np.random.randint(low=0, high=len(os.listdir(imsource))-1)
#print(patient_number)
patient_id = os.listdir(imsource)[patient_number]

negative = os.listdir(imsource+patient_id+'/0')
positive = os.listdir(imsource+patient_id+'/1')

#show first negative example
random_image_negative1 = cv.imread(imsource+str(patient_id)+"/0/"+negative[0])
plt.imshow(random_image_negative1)
plt.show()

random_image_positive1 = cv.imread(imsource+str(patient_id)+"/1/"+positive[0])
plt.imshow(random_image_positive1)
plt.show()
