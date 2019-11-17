import pickle
import data_prep as d
import os

#where we save our sampled images:
training_directory= "C:/Users/John/Desktop/Research Project/Binary Project/Samples/Training sets/"
test_directory= "C:/Users/John/Desktop/Research Project/Binary Project/Samples/Test set/"


TEST_SET_SIZE = 20000

'''
To save the test set to the text file:
'''
sampled_test_images = d.get_test_set(TEST_SET_SIZE)
test_set_file  = test_directory + "test_set.txt"
open(test_set_file, 'a').close()
with open(test_set_file, 'w') as file:
    file.write(str(sampled_test_images))

'''
Relevant for training:
'''
NUMBER_OF_SAMPLES_PER_CASE = 20

sample_sizes = [10000, 20000, 50000, 100000] #linearly incrasing so we can LINEARLY examine marginal effects
proportions = [0.01, 0.05, 0.10, 0.25] #approximately linear

'''
How many different cases are there? There are k sample sizes, and l proportions, so k*l combinations
For each case, we create 20 different samples of training data, so that we are training on each case
with different data each time (note: the test data is not changed; it was put aside to begin with)

Now we create a folder for each case in the training directory. There will be number_of_cases
folders, each representing a combination of some training size, and some proportion.
Within each folder, there should be NUMBER_OF_SAMPLES_PER_CASE text files, each of which
is a .txt file containing a list of strings which are the selected images for training.
'''

if __name__=="__main__":
    for i,sample_size in enumerate(sample_sizes):
        for j,proportion in enumerate(proportions):
            file = training_directory + "case_n_%d_p_%.2f/" % (sample_size, proportion)
            if not os.path.exists(file):
                os.makedirs(file)
            for s in range(NUMBER_OF_SAMPLES_PER_CASE):
                case = file + "sample_%d.txt" % (s+1)
                sampled_training_images = d.select_training_images(n=sample_size, p=proportion)
                print(case)
                open(case, 'a').close()    #create a text file
                with open(case, 'w') as f:
                    f.write(str(sampled_training_images))
