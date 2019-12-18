models_results = read.csv('pneumonia_models.csv', header=T)
attach(models_results)
names(models_results)

sample_sizes = c(500, 1000, 1500, 2000)
proportions = c(0.01, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5)
length(proportions)
#each case had a model trained 20 times
#first 20 cases (n=500, p=1%):


#-----------------TEST performance metrics--------------------------------



#N = 500
mean_test_specificity_500 = c()
mean_test_sensitivity_500 = c()
mean_test_f1_500 = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 500 & proportion==proportions[i])
  test_specificity=case$Test_Specificity
  test_sensitivity=case$Test_Sensitivity
  f1=case$Test_F1
  
  mean_test_specificity = mean(test_specificity, na.rm=T)
  mean_test_specificity_500[i] = mean_test_specificity
  
  mean_test_sensitivity = mean(test_sensitivity, na.rm=T)
  mean_test_sensitivity_500[i] = mean_test_sensitivity
  
  mean_test_f1 = mean(f1, na.rm = T)
  mean_test_f1_500[i] = mean_test_f1
}

mean_test_specificity_1000
mean_test_sensitivity_1000
mean_test_f1_1000

# N = 1000
mean_test_specificity_1000 = c()
mean_test_sensitivity_1000 = c()
mean_test_f1_1000 = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 1000 & proportion==proportions[i])
  test_specificity=case$Test_Specificity
  test_sensitivity=case$Test_Sensitivity
  f1=case$Test_F1
  
  mean_test_specificity = mean(test_specificity, na.rm=T)
  mean_test_specificity_1000[i] = mean_test_specificity
  
  mean_test_sensitivity = mean(test_sensitivity, na.rm=T)
  mean_test_sensitivity_1000[i] = mean_test_sensitivity
  
  mean_test_f1 = mean(f1, na.rm = T)
  mean_test_f1_1000[i] = mean_test_f1
}

mean_test_specificity_1000
mean_test_sensitivity_1000
mean_test_f1_1000

# N = 1500
mean_test_specificity_1500 = c()
mean_test_sensitivity_1500 = c()
mean_test_f1_1500 = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 1500 & proportion==proportions[i])
  test_specificity=case$Test_Specificity
  test_sensitivity=case$Test_Sensitivity
  f1=case$Test_F1
  
  mean_test_specificity = mean(test_specificity, na.rm=T)
  mean_test_specificity_1500[i] = mean_test_specificity
  
  mean_test_sensitivity = mean(test_sensitivity, na.rm=T)
  mean_test_sensitivity_1500[i] = mean_test_sensitivity
  
  mean_test_f1 = mean(f1, na.rm = T)
  mean_test_f1_1500[i] = mean_test_f1
}

mean_test_specificity_1500
mean_test_sensitivity_1500
mean_test_f1_1500


# N = 2000
mean_test_specificity_2000 = c()
mean_test_sensitivity_2000 = c()
mean_test_f1_2000 = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 2000 & proportion==proportions[i])
  test_specificity=case$Test_Specificity
  test_sensitivity=case$Test_Sensitivity
  f1=case$Test_F1
  
  mean_test_specificity = mean(test_specificity, na.rm=T)
  mean_test_specificity_2000[i] = mean_test_specificity
  
  mean_test_sensitivity = mean(test_sensitivity, na.rm=T)
  mean_test_sensitivity_2000[i] = mean_test_sensitivity
  
  mean_test_f1 = mean(f1, na.rm = T)
  mean_test_f1_2000[i] = mean_test_f1
}


#SPECIFICITY
plot(mean_test_specificity_2000, col='red', cex = 0.5,main='Average Test Specificity', 
     type='l', ylab='Average test specificity', xaxt='n', xlab = 'Proportion')
lines(mean_test_specificity_1000, col = 'blue')
lines(mean_test_specificity_1500, col = 'green')
lines(mean_test_specificity_500, col = 'black')
legend('topright', legend=c("500", "1000", "1500", "2000"),
       col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:11, labels=proportions[1:11])

#SENSITIVITY
plot(mean_test_sensitivity_2000, col='red', cex = 0.5,main='Average Test Sensitivity', 
     type='l', ylab='Average test specificity', xaxt='n', xlab = 'Proportion')
lines(mean_test_sensitivity_1000, col = 'blue')
lines(mean_test_sensitivity_1500, col = 'green')
lines(mean_test_sensitivity_500, col = 'black')
legend('bottomright', legend=c("500", "1000", "1500", "2000"),
       col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:11, labels=proportions[1:11])


#f1
plot(mean_test_f1_2000, col='red', cex = 0.5,main='Average Test F1-score', 
     type='l', ylab='Average test specificity', xaxt='n', xlab = 'Proportion')
lines(mean_test_f1_1000, col = 'blue')
lines(mean_test_f1_1500, col = 'green')
lines(mean_test_f1_500, col = 'black')
legend('bottomright', legend=c("500", "1000", "1500", "2000"),
       col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:11, labels=proportions[1:11])


#-----------------VALIDATION performance metrics--------------------------------

# N = 500
mean_val_specificity_500 = c()
mean_val_sensitivity_500 = c()
mean_val_f1_500 = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 500 & proportion==proportions[i])
  val_specificity=case$Valid_Specificity
  val_sensitivity=case$Valid_Sensitivity
  f1=case$Valid_F1
  
  mean_val_specificity = mean(val_specificity, na.rm=T)
  mean_val_specificity_500[i] = mean_val_specificity
  
  mean_val_sensitivity = mean(val_sensitivity, na.rm=T)
  mean_val_sensitivity_500[i] = mean_val_sensitivity
  
  mean_val_f1 = mean(f1, na.rm = T)
  mean_val_f1_500[i] = mean_val_f1
}

# N = 1000
mean_val_specificity_1000 = c()
mean_val_sensitivity_1000 = c()
mean_val_f1_1000 = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 1000 & proportion==proportions[i])
  val_specificity=case$Valid_Specificity
  val_sensitivity=case$Valid_Sensitivity
  f1=case$Valid_F1
  
  mean_val_specificity = mean(val_specificity, na.rm=T)
  mean_val_specificity_1000[i] = mean_val_specificity
  
  mean_val_sensitivity = mean(val_sensitivity, na.rm=T)
  mean_val_sensitivity_1000[i] = mean_val_sensitivity
  
  mean_val_f1 = mean(f1, na.rm = T)
  mean_val_f1_1000[i] = mean_val_f1
}

# N = 1500
mean_val_specificity_1500 = c()
mean_val_sensitivity_1500 = c()
mean_val_f1_1500 = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 1500 & proportion==proportions[i])
  val_specificity=case$Valid_Specificity
  val_sensitivity=case$Valid_Sensitivity
  f1=case$Valid_F1
  
  mean_val_specificity = mean(val_specificity, na.rm=T)
  mean_val_specificity_1500[i] = mean_val_specificity
  
  mean_val_sensitivity = mean(val_sensitivity, na.rm=T)
  mean_val_sensitivity_1500[i] = mean_val_sensitivity
  
  mean_val_f1 = mean(f1, na.rm = T)
  mean_val_f1_1500[i] = mean_val_f1
}




# N = 2000
mean_val_specificity_2000 = c()
mean_val_sensitivity_2000 = c()
mean_val_f1_2000 = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 2000 & proportion==proportions[i])
  val_specificity=case$Valid_Specificity
  val_sensitivity=case$Valid_Sensitivity
  f1=case$Valid_F1
  
  mean_val_specificity = mean(val_specificity, na.rm=T)
  mean_val_specificity_2000[i] = mean_val_specificity
  
  mean_val_sensitivity = mean(val_sensitivity, na.rm=T)
  mean_val_sensitivity_2000[i] = mean_val_sensitivity
  
  mean_val_f1 = mean(f1, na.rm = T)
  mean_val_f1_2000[i] = mean_val_f1
}


#SPECIFICITY
plot(mean_val_specificity_2000, col='red', cex = 0.5,main='Average Validation Specificity', 
     type='l', ylab='Average Val. Specificity', xaxt='n', xlab = 'Proportion')
lines(mean_val_specificity_1000, col = 'blue')
lines(mean_val_specificity_1500, col = 'green')
lines(mean_val_specificity_500, col = 'black')
legend('topright', legend=c("500", "1000", "1500", "2000"),
        col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:11, labels=proportions[1:11])

#SENSITIVITY
plot(mean_val_sensitivity_2000, col='red', cex = 0.5,main='Average Validation Sensitivity', 
     type='l', ylab='Average Val. Sensitivity', xaxt='n', xlab = 'Proportion')
lines(mean_val_sensitivity_1000, col = 'blue')
lines(mean_val_sensitivity_1500, col = 'green')
lines(mean_val_sensitivity_500, col = 'black')
legend('bottomright', legend=c("500", "1000", "1500", "2000"),
        col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:11, labels=proportions[1:11])

#F1
plot(mean_val_f1_2000, col='red', cex = 0.5,main='Average Validation F1 Score', 
     type='l', ylab='Average Val. F1 Score', xaxt='n', xlab = 'Proportion')
lines(mean_val_f1_1000, col = 'blue')
lines(mean_val_f1_1500, col = 'green')
lines(mean_val_f1_500, col = 'black')
legend('bottomright', legend=c("500", "1000", "1500", "2000"),
        col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:11, labels=proportions[1:11])



