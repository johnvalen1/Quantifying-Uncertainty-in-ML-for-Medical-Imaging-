''' File to manage all dataset related stuff '''

import pandas as pd
from PIL import Image
import cv2

import torch
from torch.utils.data.dataset import Dataset
from torch.utils.data import DataLoader
from torchvision import transforms

from sklearn.model_selection import train_test_split


class ChestDataset(Dataset):
    ''' Defines the Dataset for the Chest X-ray Images '''
    def __init__(self, ids, labels, transf, size = 224):
        super().__init__()

        self.size = size

        # Transforms
        self.transforms = transf

        # Images IDS
        self.ids = ids
        self.labels = torch.LongTensor(labels)

        # Calculate len of data
        self.data_len = len(self.ids)

    def __getitem__(self, index):
        # Get an ID of a specific image
        id_img = self.ids[index]
        # Open Image
        img = cv2.imread(id_img)
        img = cv2.convertScaleAbs(img)
        if img.ndim == 2:
            img = cv2.cvtColor(img,cv2.COLOR_GRAY2RGB)

        # Applies transformations
        if self.transforms:
            img = self.transforms(img)

        label = self.labels[index]

        return (img, label)

    def __len__(self):
        return self.data_len


def read_dataset(dir_img):
    ''' Read the names of the images '''
    images = pd.read_csv(dir_img)

    ids = images['ID_IMG'].tolist()
    labels = images['LABEL'].tolist()
    return ids, labels


def get_dataloaders(dir_img, size_img, batch_size=12):
    ''' Creates and return the data loaders with the images '''
    # Read the dataset
    ids, labels = read_dataset(dir_img)

    num_workers = 0 #os.cpu_count()

    #Transformations
    train_transform = transforms.Compose([
        transforms.ToPILImage(mode='RGB'),
        transforms.Resize([size_img]*2, Image.BICUBIC),
        # Augmentation
        #transforms.RandomAffine(degrees=180, translate=(0.02, 0.02),
        #    scale=(0.98, 1.02), shear=2, fillcolor=(0, 0, 0)),
        #transforms.RandomHorizontalFlip(),
        #transforms.RandomVerticalFlip(),
        transforms.ToTensor(),
        transforms.Normalize([0.4815, 0.4815, 0.4815], [0.2235, 0.2235, 0.2235])
    ])

    # Split datasets
    train_images, valid_images, train_labels, valid_labels = train_test_split(ids, labels,
        test_size=0.20, stratify=labels)
    print("Training size: ", len(train_images))
    print("Validation size: ", len(valid_images))

    # Create the datasets
    train_dataset = ChestDataset(ids=train_images, labels=train_labels, transf=train_transform)
    val_dataset = ChestDataset(ids=valid_images, labels=valid_labels, transf=train_transform)


    # Create the loaders
    train_loader = DataLoader(train_dataset, batch_size=batch_size, num_workers=num_workers)
    val_loader = DataLoader(val_dataset, batch_size=batch_size, num_workers=num_workers)

    return train_loader, val_loader



def get_test_dataloader(dir_img, size_img, batch_size=12):
    ''' Create and return the loader for testing images (no filters or transformations) '''
    # Read the dataset
    ids, labels = read_dataset(dir_img)
    num_workers = 0 #os.cpu_count()

    # Transforms
    test_transform = transforms.Compose([
        transforms.ToPILImage(mode='RGB'),
        transforms.Resize([size_img]*2, Image.BICUBIC),
        transforms.ToTensor(),
        transforms.Normalize([0.4815, 0.4815, 0.4815], [0.2235, 0.2235, 0.2235])
    ])

    # Create the dataset
    test_dataset = ChestDataset(ids=ids, labels=labels, transf=test_transform)

    # Create the loaders
    test_loader = DataLoader(test_dataset, batch_size=batch_size, num_workers=num_workers)
    
    return test_loader


