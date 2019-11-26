''' File to control hyperparameters and flow of the program '''
import random
import os
import torch
import torch.nn as nn
import numpy as np
from read_dataset import get_dataloaders, get_test_dataloader
from model import ResNet18
import wandb
import csv   


def seed_everything(seed):
    ''' Set random seed on all environments '''
    random.seed(seed)
    os.environ['PYTHONHASHSEED'] = str(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)
    torch.backends.cudnn.deterministic = True



def start():
    ''' Main function, flow of program '''

    # wandb setup
    hyperparameters_default = dict(
        SEED = 123,
        TRAIN_FILE = './datasets/n_500_p_0_01/dataset_1.csv',
        TEST_FILE = './datasets/test_set.csv',
        LEARNING_RATE = 0.001,
        NUM_EPOCHS = 3,
        IMAGE_SIZE = 224,
        NUM_CLASSES = 2,
        OPTIMIZER = 'ADAM',
        BATCH_SIZE = 32
    )

    run = wandb.init(project="imbalance_chest_x_ray", config=hyperparameters_default)
    config = wandb.config

    file_name = config.TRAIN_FILE.split('/')

    run.name = file_name[-2] + '_' + file_name[-1].replace('.csv', '')

    run.save()
    

    # To stablish a seed on all the project
    #seed_everything(config.SEED)

    # Images Loaders
    train_loader, val_loader = get_dataloaders(config.TRAIN_FILE, config.IMAGE_SIZE, config.BATCH_SIZE)
    test_loader = get_test_dataloader(config.TEST_FILE, config.IMAGE_SIZE, config.BATCH_SIZE)

    # Model
    appr = ResNet18(name=run.name, num_classes=config.NUM_CLASSES)
    appr.build_model()
    wandb.watch(appr.model, log="all")

    # Creates the criterion (used in training and testing)
    criterion = nn.CrossEntropyLoss()

    # Changes the weights based on error (using Stochastic Gradient Descent)
    if config.OPTIMIZER == 'ADAM':
        optimizer = torch.optim.Adam(appr.model.parameters(), lr=config.LEARNING_RATE)

    # Training and Validation of the model
    appr.train_val(loaders=(train_loader, val_loader), criterion=criterion, \
            optimizer=optimizer, num_epochs=config.NUM_EPOCHS)

    # Test the model
    appr.test(loader=test_loader, criterion=criterion)

    # Save run results
    with open(r'./results.csv', 'a') as f:
        writer = csv.writer(f)
        comb = file_name[-2].split('_')
        fields = [comb[1], comb[3]+'.'+comb[4], file_name[-1]] + appr.finish() 
        writer.writerow(fields)


# if __name__ == "__main__":
#     main()