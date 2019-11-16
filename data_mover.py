import torch
import os
import numpy as np
import shutil
'''
This file will prepare training data and test data... we are not validating.
'''
imsource = "C:/Users/John/Desktop/Research Project/Binary Project/Breast Cancer Data/"
positive_destination = "C:/Users/John/Desktop/Research Project/Binary Project/Negative cases/"
negative_destination = "C:/Users/John/Desktop/Research Project/Binary Project/Positive cases/"

neg_label = "0"
pos_label = "1"

#move all negative cases to negative_source, and positive cases to positive_source
for case in os.listdir(imsource):
    for label in os.listdir(imsource+case+"/"):
        if label == "0":
            neg = os.path.join(imsource, case+"/"+label)
            shutil.copy(src=neg, dst=negative_destination, follow_symlinks=True)
        elif label == "1":
            pos = os.path.join(imsource, case+"/"+label)
            print(pos)
            shutil.copy(src=pos, dst=positive_destination, follow_symlinks=True)
