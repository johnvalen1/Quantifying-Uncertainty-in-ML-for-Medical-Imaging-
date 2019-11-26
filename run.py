import glob
import wandb
from main import start


sample_sizes = [500, 1000, 1500, 2000]
proportions = [0.01, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5]
dataset_samples = 20

for sample_size in sample_sizes:
    for prop in proportions:

        datasets = glob.glob('./datasets/n_'+str(sample_size)+'_p_'+str(prop).replace('.','_')+'/*.csv')

        sweep_config = {
            'method': 'grid',
            'parameters': {
                'TRAIN_FILE': {
                    'values': [datasets[0]]
                },
                'PROPORTION': {
                    'values': [prop]
                },
                'SAMPLE_SIZE': {
                    'values': [sample_size]
                }

            }
        }

        sweep_id = wandb.sweep(sweep_config)
        wandb.agent(sweep_id, function=start)