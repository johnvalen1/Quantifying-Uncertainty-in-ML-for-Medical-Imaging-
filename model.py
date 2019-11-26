''' Definition of Approach: ResNet '''
from __future__ import absolute_import
import torch.nn as nn
from torchvision import models

import glob
import torch
from ignite.engine import Events, create_supervised_trainer, create_supervised_evaluator
from ignite.metrics import Accuracy, Loss, Precision, Recall, ConfusionMatrix
from ignite.handlers import ModelCheckpoint
import wandb

class ResNet18():
    ''' ResNet: 18 layers variation '''
    def __init__(self, name, num_classes=2):
        self.num_classes = num_classes
        self.model = None
        self.name = name
        self.validation_metrics = None
        self.test_metrics = None

    def build_model(self):
        self.model = models.resnet18(pretrained=True)

        # To freeze layers
        for param in self.model.parameters():
            param.requires_grad = False
        
        num_ftrs = self.model.fc.in_features
        self.model.fc = nn.Linear(num_ftrs, self.num_classes)


    def train_val(self, loaders, criterion, optimizer, num_epochs):
        ''' Training and Validation for most Approaches '''
        # Set up
        train_loader, val_loader = loaders
        device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        log_interval = 5
        best_metrics = {'celoss': 100000, 'accuracy': 0, 'precision':0, 'recall': 0, 'f1': 0, 'confmatrix': None}

        # Metrics
        train_metrics = {'accuracy': Accuracy(), 'celoss': Loss(criterion)}
        precision = Precision()
        recall = Recall()
        F1 = (precision * recall * 2 / (precision + recall)).mean()
        val_metrics = {'accuracy': Accuracy(), 'celoss': Loss(criterion), 'precision': Precision(),
            'recall': recall, 'f1': F1, 'confmatrix': ConfusionMatrix(self.num_classes)}

        # Training and Validation jobs
        trainer = create_supervised_trainer(self.model, optimizer, criterion, device=device)        
        train_evaluator = create_supervised_evaluator(self.model, metrics=train_metrics, device=device)        
        val_evaluator = create_supervised_evaluator(self.model, metrics=val_metrics, device=device)

        # Report loss on every iteration
        @trainer.on(Events.ITERATION_COMPLETED)
        def log_training_loss(engine):
            itera = (engine.state.iteration - 1) % len(train_loader) + 1
            if itera % log_interval == 0:
                print("Epoch[{}] Iteration[{}/{}] Loss: {:.4f}"
                    "".format(engine.state.epoch, itera, len(train_loader), engine.state.output))

        # Report training metrics on every epoch
        @trainer.on(Events.EPOCH_COMPLETED)
        def log_training_results(engine):
            train_evaluator.run(train_loader)
            metrics = train_evaluator.state.metrics
            avg_accuracy = metrics['accuracy']
            avg_celoss = metrics['celoss']
            print("Training Results - Epoch: {}  Avg Accuracy: {:.4f} Avg Loss: {:.4f}"
                .format(engine.state.epoch, avg_accuracy, avg_celoss))
            # wandb
            wandb.log({'Training_Avg_Loss': avg_celoss, 'Training_Avg_Accuracy': avg_accuracy}, step=engine.state.epoch)


        # Report validation metrics on every epoch
        @trainer.on(Events.EPOCH_COMPLETED)
        def log_validation_results(engine):
            val_evaluator.run(val_loader)
            metrics = val_evaluator.state.metrics
            avg_accuracy = metrics['accuracy']
            avg_celoss = metrics['celoss']
            print("Validation Results - Epoch: {}  Avg accuracy: {:.4f} Avg loss: {:.4f}"
                .format(engine.state.epoch, avg_accuracy, avg_celoss))
            # wandb
            wandb.log({'Validation_Avg_Loss': avg_celoss, 'Validation_Avg_Accuracy': avg_accuracy}, step=engine.state.epoch)
            
            # Saving the best metrics
            if avg_celoss < best_metrics['celoss']:
                best_metrics['celoss'] =    metrics['celoss']
                best_metrics['accuracy'] =  metrics['accuracy']
                best_metrics['precision'] = metrics['precision']
                best_metrics['recall'] =    metrics['recall']
                best_metrics['f1'] =        metrics['f1']
                best_metrics['confmatrix'] = metrics['confmatrix']


        # Store the best model
        def score_fn(engine):
            # Save with accuracy
            return engine.state.metrics['accuracy']
            # Save with loss
            #score = engine.state.metrics['celoss']
            #return -score
        best_model_handler = ModelCheckpoint(dirname=wandb.run.dir,
                                            filename_prefix = "best",
                                            n_saved=1,
                                            score_name="accuracy",
                                            require_empty=False,
                                            score_function=score_fn)
        val_evaluator.add_event_handler(Events.COMPLETED, best_model_handler, {'model': self.model})


        # Start the training
        trainer.run(train_loader, max_epochs=num_epochs)

        # Report the best metrics
        print("\nBest Validation Epoch: \nAvg accuracy: {:.4f} \nAvg loss: {:.4f} \
            \nPrecision: {} \nRecall: {} \nF1: {} \nConfussion Matrix: \n{}"
                .format(best_metrics['accuracy'], best_metrics['celoss'], 
                best_metrics['precision'].numpy(), best_metrics['recall'].numpy(), 
                best_metrics['f1'], best_metrics['confmatrix'].numpy()))
        # wandb
        wandb.log({
            'Best_Epoch_Validation_Accuracy': best_metrics['accuracy'], 
            'Best_Epoch_Validation_Loss': best_metrics['celoss'],
            'Best_Epoch_Validation_Precision_Pneumonia': best_metrics['precision'][0],
            'Best_Epoch_Validation_Precision_Control': best_metrics['precision'][1],
            'Best_Epoch_Validation_Recall_Pneumonia': best_metrics['recall'][0],
            'Best_Epoch_Validation_Recall_Control': best_metrics['recall'][1],
            'Best_Epoch_Validation_F1': best_metrics['f1'],
        })

        table = wandb.Table(columns=["CM", "Predicted_Pneumonia", "Predicted_Control"])
        table.add_data("Actual_Control", best_metrics['confmatrix'][1][0], best_metrics['confmatrix'][1][1])
        table.add_data("Actual_Pneumonia", best_metrics['confmatrix'][0][0], best_metrics['confmatrix'][0][1])
        wandb.log({"Validation Confussion Matrix": table})

        self.validation_metrics = best_metrics



    def test(self, loader, criterion):
        ''' Testing forward for most Approaches '''
        # Set Up
        weights = glob.glob(wandb.run.dir+"/*.pth")[0]
        self.build_model()
        self.model.load_state_dict(torch.load(weights))
        device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

        # Metrics
        precision = Precision()
        recall = Recall()
        F1 = (precision * recall * 2 / (precision + recall)).mean()
        metrics = {'accuracy': Accuracy(), 'celoss': Loss(criterion), 'precision': Precision(),
            'recall': recall, 'f1': F1, 'confmatrix': ConfusionMatrix(self.num_classes)}

        # Test job
        evaluator = create_supervised_evaluator(self.model, metrics=metrics, device=device)
        evaluator.run(loader)
        metrics = evaluator.state.metrics

        # Report the metrics
        print("\nTest Set: \nAvg accuracy: {:.4f} \nAvg loss: {:.4f} \
            \nPrecision: {} \nRecall: {} \nF1: {} \nConfussion Matrix: \n{}"
                .format(metrics['accuracy'], metrics['celoss'], 
                metrics['precision'].numpy(), metrics['recall'].numpy(), 
                metrics['f1'], metrics['confmatrix'].numpy()))
        
        # wandb
        wandb.log({
            'Test_Accuracy': metrics['accuracy'], 
            'Test_Loss': metrics['celoss'],
            'Test_Precision_Pneumonia': metrics['precision'][0],
            'Test_Precision_Control': metrics['precision'][1],
            'Test_Recall_Pneumonia': metrics['recall'][0],
            'Test_Recall_Control': metrics['recall'][1],
            'Test_F1': metrics['f1'],
        })

        table = wandb.Table(columns=["CM", "Predicted_Pneumonia", "Predicted_Control"])
        table.add_data("Actual_Control", metrics['confmatrix'][1][0], metrics['confmatrix'][1][1])
        table.add_data("Actual_Pneumonia", metrics['confmatrix'][0][0], metrics['confmatrix'][0][1])
        wandb.log({"Testing Confussion Matrix": table})

        self.test_metrics = metrics


    def finish(self):
        ''' Closes open connection '''
        return [
            self.validation_metrics['accuracy'], self.validation_metrics['celoss'], 
            self.validation_metrics['precision'].numpy(), self.validation_metrics['recall'].numpy(),
            self.validation_metrics['f1'], self.validation_metrics['confmatrix'].numpy(),
            self.test_metrics['accuracy'], self.test_metrics['celoss'], 
            self.test_metrics['precision'].numpy(), self.test_metrics['recall'].numpy(),
            self.test_metrics['f1'], self.test_metrics['confmatrix'].numpy()
        ]