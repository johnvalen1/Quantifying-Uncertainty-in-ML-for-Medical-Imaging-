import glob
import pandas as pd
import os
import shutil
import random
from sklearn.model_selection import train_test_split

DATASET_PATH = './chest_xray/'
OUTPUT_PATH = './datasets/'


# Delete if there already are datasets made
if os.path.exists(OUTPUT_PATH):
    shutil.rmtree(OUTPUT_PATH)
os.mkdir(OUTPUT_PATH)


# Original dataset
disease = glob.glob(DATASET_PATH+'PNEUMONIA/*')
control = glob.glob(DATASET_PATH+'NORMAL/*')


################## TEST SET ###################

# Create test set
random.shuffle(disease)
random.shuffle(control)
test_disease = disease[:500]
test_control = control[:500]

# Shuffle all test images
images_and_labels = list(zip(test_disease + test_control, [0]*len(test_disease) + [1]*len(test_control)))
random.shuffle(images_and_labels)
test_images, test_labels = zip(*images_and_labels)

# Save test set
df_test = pd.DataFrame({'ID_IMG': test_images, 'LABEL': test_labels}, columns=['ID_IMG', 'LABEL'])
df_test.to_csv(OUTPUT_PATH+'test_set.csv')


################ TRAINING AND VALIDATION SETS ###############


# Dataset without test images
disease = disease[500:]
control = control[500:]


# Sample sizes and proportions
sample_sizes = [500, 1000, 1500, 2000]
proportions = [0.01, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5]
dataset_samples = 20

# Loop to iterate over all dimensions
for sample_size in sample_sizes:
    print('Sample size: ', sample_size)
    for prop in proportions:
        print('Proportion: ', prop)

        # Save path
        dir_path = OUTPUT_PATH + 'n_' + str(sample_size) + '_p_' + str(prop).replace('.', '_') + '/'
        os.mkdir(dir_path)

        for sample in range(1, dataset_samples+1):
            
            # Sample images
            control_amount = int(prop * sample_size)
            control_samples = random.sample(control, control_amount)
            disease_samples = random.sample(disease, sample_size - control_amount)

            # Create a dataset and shuffle
            images_and_labels = list(zip(disease_samples + control_samples, [0]*len(disease_samples) + [1]*len(control_samples)))
            random.shuffle(images_and_labels)
            train_images, train_labels = zip(*images_and_labels)
            
            # Save dataset
            train_df = pd.DataFrame({'ID_IMG': train_images, 'LABEL': train_labels}, columns=['ID_IMG', 'LABEL'])
            train_df.to_csv(dir_path + 'dataset_' + str(sample) + '.csv')