import pickle
import data_prep as d
import os

#where we save our sampled images:
training_directory= "C:/Users/John/Desktop/Research Project/Binary Project/Samples/Training sets/"
test_directory= "C:/Users/John/Desktop/Research Project/Binary Project/Samples/Test sets/"

'''
In this code, I have assigned ID's to the samples. These ID's are based on the sample size used,
and the proportion used. For example, if our sample sizes are [1000,5000,10000] then a sample size
of 10000 has ID 3 and if our proportions are [0.01, 0.1, 0.5] then a prop. of 0.5 has ID 3.
Then a sample will be saved into a text file in both training and test directories of the form:
'training_sample_sizeID_3_proportionID_3.txt' and 'test_sample_3_3.txt'
This indicates that we should train our model AND test it on these two samples. This way we
are consistent. Note that test_sample_3_3.txt does NOT contain 10000 test images and a proportion of 0.5

If n = size of training set, this test sample has size n/0.9 - n,
because we pretend that we have an 90-10 train test split.
So if the sample_size = 10000, then the test set would be about 1,111 images. Generally, the proportion is balanced for
testing by default (p_test = 0.5, but we can change this).

When we save an n-sized sample, its a list of n strings (image names like
'C:/Users/John/Desktop/Research Project/Binary Project/Breast Cancer Data\\9124\\1\\9124_idx5_x1051_y901_class1.png') in a .txt document for each sample.
The problem here is that the directory appears in the string... maybe we should remove it for readability?

'''

sample_sizes = [5000, 10000, 15000, 20000] #linearly incrasing so we can LINEARLY examine marginal effects
proportions = [0.01, 0.05, 0.10, 0.15] #approximately linear

def get_test_set_size(training_set_size):
    return int(training_set_size/0.8)-training_set_size

if __name__=="__main__":
    for i,sample_size in enumerate(sample_sizes):
        #test_set_size = get_test_set_size(sample_size)
        for j,proportion in enumerate(proportions):
            training_sample_txt = training_directory + "training_sample_sizeID_%d_proportionID_%d.txt" % (i+1,j+1)
            sampled_training_images = d.select_training_images(n=sample_size, p=proportion)
            corresponding_test_images = d.select_test_images(sampled_training_images)
            open(training_sample_txt, 'a').close()    #create a text file
            with open(training_sample_txt, 'w') as file:
                file.write(str(sampled_training_images))
            test_sample = test_directory + "test_sample_%d_%d.txt" % (i+1, j+1)
            open(test_sample, 'a').close()
            with open(test_sample, 'w') as file:
                file.write(str(corresponding_test_images))
