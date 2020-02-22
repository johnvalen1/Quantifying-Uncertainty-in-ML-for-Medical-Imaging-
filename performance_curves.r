models_results = read.csv('formatted_results.csv', header=T)
attach(models_results)
names(models_results)

sample_sizes = c(500, 750, 1000, 1250)
proportions = c(0.01, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 0.99)
length(proportions)
#each case had a model trained 20 times
#first 20 cases (n=500, p=1%):


#-----------------TEST performance metrics--------------------------------


#N = 500
mean_test_specificity_500 = c()
mean_test_sensitivity_500 = c()
mean_test_f1_500 = c()
mean_test_acc_500 = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 500 & proportion==proportions[i])
  test_specificity=case$Test_Specificity
  test_sensitivity=case$Test_Sensitivity
  f1=case$Test_F1
  acc=case$Test_Accuracy
  
  mean_test_specificity = mean(test_specificity, na.rm=T)
  mean_test_specificity_500[i] = mean_test_specificity
  
  mean_test_sensitivity = mean(test_sensitivity, na.rm=T)
  mean_test_sensitivity_500[i] = mean_test_sensitivity
  
  mean_test_f1 = mean(f1, na.rm = T)
  mean_test_f1_500[i] = mean_test_f1
  
  mean_test_acc = mean(acc, na.rm = T)
  mean_test_acc_500[i] = mean_test_acc
}
mean_test_specificity_500
mean_test_sensitivity_500
mean_test_f1_500
mean_test_acc_500

# N = 750
mean_test_specificity_750 = c()
mean_test_sensitivity_750 = c()
mean_test_f1_750 = c()
mean_test_acc_750 = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 750 & proportion==proportions[i])
  test_specificity=case$Test_Specificity
  test_sensitivity=case$Test_Sensitivity
  f1=case$Test_F1
  acc=case$Test_Accuracy
  
  mean_test_specificity = mean(test_specificity, na.rm=T)
  mean_test_specificity_750[i] = mean_test_specificity
  
  mean_test_sensitivity = mean(test_sensitivity, na.rm=T)
  mean_test_sensitivity_750[i] = mean_test_sensitivity
  
  mean_test_f1 = mean(f1, na.rm = T)
  mean_test_f1_750[i] = mean_test_f1
  
  mean_test_acc = mean(acc, na.rm = T)
  mean_test_acc_750[i] = mean_test_acc
}

mean_test_specificity_750
mean_test_sensitivity_750
mean_test_f1_750
mean_test_acc_750


# N = 1000
mean_test_specificity_1000 = c()
mean_test_sensitivity_1000 = c()
mean_test_f1_1000 = c()
mean_test_acc_1000 = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 1000 & proportion==proportions[i])
  test_specificity=case$Test_Specificity
  test_sensitivity=case$Test_Sensitivity
  f1=case$Test_F1
  acc=case$Test_Accuracy
  
  mean_test_specificity = mean(test_specificity, na.rm=T)
  mean_test_specificity_1000[i] = mean_test_specificity
  
  mean_test_sensitivity = mean(test_sensitivity, na.rm=T)
  mean_test_sensitivity_1000[i] = mean_test_sensitivity
  
  mean_test_f1 = mean(f1, na.rm = T)
  mean_test_f1_1000[i] = mean_test_f1
  
  mean_test_acc = mean(acc, na.rm = T)
  mean_test_acc_1000[i] = mean_test_acc
}

mean_test_specificity_1000
mean_test_sensitivity_1000
mean_test_f1_1000
mean_test_acc_1000


# N = 1250
mean_test_specificity_1250 = c()
mean_test_sensitivity_1250 = c()
mean_test_f1_1250 = c()
mean_test_acc_1250 = c()

for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 1250 & proportion==proportions[i])
  test_specificity=case$Test_Specificity
  test_sensitivity=case$Test_Sensitivity
  f1=case$Test_F1
  acc=case$Test_Accuracy
  
  mean_test_specificity = mean(test_specificity, na.rm=T)
  mean_test_specificity_1250[i] = mean_test_specificity
  
  mean_test_sensitivity = mean(test_sensitivity, na.rm=T)
  mean_test_sensitivity_1250[i] = mean_test_sensitivity
  
  mean_test_f1 = mean(f1, na.rm = T)
  mean_test_f1_1250[i] = mean_test_f1
  
  mean_test_acc = mean(acc, na.rm = T)
  mean_test_acc_1250[i] = mean_test_acc
}


#SPECIFICITY
png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Comparisons//test_spec.png")
plot(mean_test_specificity_1250, col='red', cex = 0.5,main='Average Test Specificity', 
     type='l',ylim=c(0,1), ylab='Average test specificity', xaxt='n', xlab = 'Proportion of healthy images')
lines(mean_test_specificity_1000, col = 'green')
lines(mean_test_specificity_750, col = 'blue')
lines(mean_test_specificity_500, col = 'black')
legend('bottomleft', legend=c("500", "750", "1000", "1250"),
       col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:length(proportions), labels=proportions[1:length(proportions)])
dev.off()


#SENSITIVITY
png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Comparisons//test_sens.png")
plot(mean_test_sensitivity_1250, col='red', cex = 0.5,main='Average Test Sensitivity', 
     type='l', ylab='Average test sensitivity', xaxt='n', xlab = 'Proportion of healthy images')
lines(mean_test_sensitivity_1000, col = 'green')
lines(mean_test_sensitivity_750, col = 'blue')
lines(mean_test_sensitivity_500, col = 'black')
legend('bottomright', legend=c("500", "750", "1000", "1250"),
       col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:length(proportions), labels=proportions[1:length(proportions)])
dev.off()

#f1
png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Comparisons//test_f1.png")
plot(mean_test_f1_1250, col='red', cex = 0.5,main='Average Test F1-score', 
     type='l', ylab='Average test f1', xaxt='n', xlab = 'Proportion')
lines(mean_test_f1_1000, col = 'green')
lines(mean_test_f1_750, col = 'blue')
lines(mean_test_f1_500, col = 'black')
legend('bottom', legend=c("500", "750", "1000", "1250"),
       col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:length(proportions), labels=proportions[1:length(proportions)])
dev.off()

#accuracy
png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Comparisons//test_acc.png")
plot(mean_test_acc_1250, col='red', cex = 0.5,main='Average Test Accuracy', 
     type='l', ylab='Average test accuracy', xaxt='n', xlab = 'Proportion')
lines(mean_test_acc_1000, col = 'green')
lines(mean_test_acc_750, col = 'blue')
lines(mean_test_acc_500, col = 'black')
legend('bottom', legend=c("500", "750", "1000", "1250"),
       col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:length(proportions), labels=proportions[1:length(proportions)])
dev.off()



#-----------------VALIDATION performance metrics--------------------------------
#N = 500
mean_val_specificity_500 = c()
mean_val_sensitivity_500 = c()
mean_val_f1_500 = c()
mean_val_acc_500 = c()

for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 500 & proportion==proportions[i])
  val_specificity=case$Valid_Specificity
  val_sensitivity=case$Valid_Sensitivity
  f1=case$Valid_F1
  acc=case$Valid_Accuracy
  
  mean_val_specificity = mean(val_specificity, na.rm=T)
  mean_val_specificity_500[i] = mean_val_specificity
  
  mean_val_sensitivity = mean(val_sensitivity, na.rm=T)
  mean_val_sensitivity_500[i] = mean_val_sensitivity
  
  mean_val_f1 = mean(f1, na.rm = T)
  mean_val_f1_500[i] = mean_val_f1
  
  mean_val_acc = mean(acc, na.rm = T)
  mean_val_acc_500[i] = mean_val_acc
}
mean_val_specificity_500
mean_val_sensitivity_500
mean_val_f1_500
mean_val_acc_500

# N = 750
mean_val_specificity_750 = c()
mean_val_sensitivity_750 = c()
mean_val_f1_750 = c()
mean_val_acc_750 = c()

for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 750 & proportion==proportions[i])
  val_specificity=case$Valid_Specificity
  val_sensitivity=case$Valid_Sensitivity
  f1=case$Valid_F1
  acc=case$Valid_Accuracy
  
  mean_val_specificity = mean(val_specificity, na.rm=T)
  mean_val_specificity_750[i] = mean_val_specificity
  
  mean_val_sensitivity = mean(val_sensitivity, na.rm=T)
  mean_val_sensitivity_750[i] = mean_val_sensitivity
  
  mean_val_f1 = mean(f1, na.rm = T)
  mean_val_f1_750[i] = mean_val_f1
  
  mean_val_acc = mean(acc, na.rm = T)
  mean_val_acc_750[i] = mean_val_acc
}

mean_val_specificity_750
mean_val_sensitivity_750
mean_val_f1_750
mean_val_acc_750


# N = 1000
mean_val_specificity_1000 = c()
mean_val_sensitivity_1000 = c()
mean_val_f1_1000 = c()
mean_val_acc_1000 = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 1000 & proportion==proportions[i])
  val_specificity=case$Valid_Specificity
  val_sensitivity=case$Valid_Sensitivity
  f1=case$Valid_F1
  acc=case$Valid_Accuracy
  
  mean_val_specificity = mean(val_specificity, na.rm=T)
  mean_val_specificity_1000[i] = mean_val_specificity
  
  mean_val_sensitivity = mean(val_sensitivity, na.rm=T)
  mean_val_sensitivity_1000[i] = mean_val_sensitivity
  
  mean_val_f1 = mean(f1, na.rm = T)
  mean_val_f1_1000[i] = mean_val_f1
  
  mean_val_acc = mean(acc, na.rm = T)
  mean_val_acc_1000[i] = mean_val_acc
}

mean_val_specificity_1000
mean_val_sensitivity_1000
mean_val_f1_1000
mean_val_acc_1000


# N = 1250
mean_val_specificity_1250 = c()
mean_val_sensitivity_1250 = c()
mean_val_f1_1250 = c()
mean_val_acc_1250 = c()

for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 1250 & proportion==proportions[i])
  val_specificity=case$Valid_Specificity
  val_sensitivity=case$Valid_Sensitivity
  f1=case$Valid_F1
  acc=case$Valid_Accuracy
  
  mean_val_specificity = mean(val_specificity, na.rm=T)
  mean_val_specificity_1250[i] = mean_val_specificity
  
  mean_val_sensitivity = mean(val_sensitivity, na.rm=T)
  mean_val_sensitivity_1250[i] = mean_val_sensitivity
  
  mean_val_f1 = mean(f1, na.rm = T)
  mean_val_f1_1250[i] = mean_val_f1
  
  mean_val_acc = mean(acc, na.rm = T)
  mean_val_acc_1250[i] = mean_val_acc
}

mean_val_specificity_1250
mean_val_sensitivity_1250
mean_val_f1_1250
mean_val_acc_1250

#SPECIFICITY
png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Comparisons//val_spec.png")
plot(mean_val_specificity_1250, col='red', cex = 0.5,main='Average Valid. Specificity', 
     type='l',ylim=c(0,1), ylab='Average validation specificity', xaxt='n', xlab = 'Proportion of healthy images')
lines(mean_val_specificity_1000, col = 'green')
lines(mean_val_specificity_750, col = 'blue')
lines(mean_val_specificity_500, col = 'black')
legend('bottomleft', legend=c("500", "750", "1000", "1250"),
       col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:length(proportions), labels=proportions[1:length(proportions)])
dev.off()

#SENSITIVITY
png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Comparisons//val_sens.png")
plot(mean_val_sensitivity_1250, col='red', cex = 0.5,main='Average Valid. Sensitivity', 
     type='l', ylab='Average validation sensitivity', xaxt='n', xlab = 'Proportion of healthy images')
lines(mean_val_sensitivity_1000, col = 'green')
lines(mean_val_sensitivity_750, col = 'blue')
lines(mean_val_sensitivity_500, col = 'black')
legend('bottomright', legend=c("500", "750", "1000", "1250"),
       col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:length(proportions), labels=proportions[1:length(proportions)])
dev.off()

#f1
png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Comparisons//val_f1.png")
plot(mean_val_f1_1250, col='red', cex = 0.5,main='Average Valid. F1-score', 
     type='l', ylab='Average validation f1', xaxt='n', xlab = 'Proportion')
lines(mean_val_f1_1000, col = 'green')
lines(mean_val_f1_750, col = 'blue')
lines(mean_val_f1_500, col = 'black')
legend('bottom', legend=c("500", "750", "1000", "1250"),
       col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:length(proportions), labels=proportions[1:length(proportions)])
dev.off()

#accuracy
png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Comparisons//val_acc.png")
plot(mean_val_acc_1250, col='red', cex = 0.5,main='Average Valid. Accuracy', 
     type='l', ylim=c(0.9,1), ylab='Average validation accuracy', xaxt='n', xlab = 'Proportion')
lines(mean_val_acc_1000, col = 'green')
lines(mean_val_acc_750, col = 'blue')
lines(mean_val_acc_500, col = 'black')
legend('top', legend=c("500", "750", "1000", "1250"),
       col=c("black", "blue", "green", "red"), lty=1:2, cex=0.8)
axis(1, at=1:length(proportions), labels=proportions[1:length(proportions)])
dev.off()



#----------------- PLOTS WITH CONFIDENCE INTERVALS ------------------------------
library('ggplot2')


#TEST METRICS


#SPECIFICITY FIRST


#N = 500

mean_test_specificity_500
#standard error
se_spec_500 = sqrt(var(mean_test_specificity_500))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_specificity_500 + se_spec_500 < 1, mean_test_specificity_500 + se_spec_500, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_specificity_500,
  lower = mean_test_specificity_500 - se_spec_500,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//500//test_spec.png")
ggplot(df, aes(proportions, mean_test_specificity_500)) + 
  geom_point() + geom_line() + labs(title="Test Specificity with Standard Error, n = 500",
                       x ="Proportion", y = "Avg. Test Specificity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 750
mean_test_specificity_750
#standard error
se_spec_750 = sqrt(var(mean_test_specificity_750))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_specificity_750 + se_spec_750 < 1, mean_test_specificity_750 + se_spec_750, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_specificity_750,
  lower = mean_test_specificity_750 - se_spec_750,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//750//test_spec.png")
ggplot(df, aes(proportions, mean_test_specificity_750)) + 
  geom_point() + geom_line() + labs(title="Test Specificity with Standard Error, n = 750",
                      x ="Proportion", y = "Avg. Test Specificity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1000
mean_test_specificity_1000
#standard error
se_spec_1000 = sqrt(var(mean_test_specificity_1000))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_specificity_1000 + se_spec_1000 < 1, mean_test_specificity_1000 + se_spec_1000, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_specificity_1000,
  lower = mean_test_specificity_1000 - se_spec_1000,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//1000//test_spec.png")
ggplot(df, aes(proportions, mean_test_specificity_1000)) + 
  geom_point() + geom_line() + labs(title="Test Specificity with Standard Error, n = 1000",
                      x ="Proportion", y = "Avg. Test Specificity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1250
mean_test_specificity_1250
#standard error
se_spec_1250 = sqrt(var(mean_test_specificity_1250))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_specificity_1250 + se_spec_1250 < 1, mean_test_specificity_1250 + se_spec_1250, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_specificity_1250,
  lower = mean_test_specificity_1250 - se_spec_1250,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//1250//test_spec.png")
ggplot(df, aes(proportions, mean_test_specificity_1250)) + 
  geom_point() + geom_line() + labs(title="Test Specificity with Standard Error, n = 1250",
                      x ="Proportion", y = "Avg. Test Specificity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()




#SENSITIVITY

#N = 500
mean_test_sensitivity_500
#standard error
se_sens_500 = sqrt(var(mean_test_sensitivity_500))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_sensitivity_500 + se_sens_500 < 1, mean_test_sensitivity_500 + se_sens_500, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_sensitivity_500,
  lower = mean_test_sensitivity_500 - se_sens_500,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//500//test_sens.png")
ggplot(df, aes(proportions, mean_test_sensitivity_500)) + 
  geom_point() + geom_line() + labs(title="Test Sensitivity with Standard Error, n = 500",
                      x ="Proportion", y = "Avg. Test Sensitivity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 750
mean_test_sensitivity_750
#standard error
se_sens_750 = sqrt(var(mean_test_sensitivity_750))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_sensitivity_750 + se_sens_750 < 1, mean_test_sensitivity_750 + se_sens_750, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_sensitivity_750,
  lower = mean_test_sensitivity_750 - se_sens_750,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//750//test_sens.png")
ggplot(df, aes(proportions, mean_test_sensitivity_750)) + 
  geom_point() + geom_line() + labs(title="Test Sensitivity with Standard Error, n = 750",
                      x ="Proportion", y = "Avg. Test Sensitivity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1000
mean_test_sensitivity_1000
#standard error
se_sens_1000 = sqrt(var(mean_test_sensitivity_1000))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_sensitivity_750 + se_sens_1000 < 1, mean_test_sensitivity_1000 + se_sens_1000, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_sensitivity_1000,
  lower = mean_test_sensitivity_1000 - se_sens_1000,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//1000//test_sens.png")
ggplot(df, aes(proportions, mean_test_sensitivity_1000)) + 
  geom_point() + geom_line() + labs(title="Test Sensitivity with Standard Error, n = 1000",
                                    x ="Proportion", y = "Avg. Test Sensitivity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1250
mean_test_sensitivity_1250
#standard error
se_sens_1250 = sqrt(var(mean_test_sensitivity_1250))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_sensitivity_1250 + se_sens_1250 < 1, mean_test_sensitivity_1250 + se_sens_1250, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_sensitivity_1250,
  lower = mean_test_sensitivity_1250 - se_sens_1250,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//1250//test_sens.png")
ggplot(df, aes(proportions, mean_test_sensitivity_1250)) + 
  geom_point() + geom_line() + labs(title="Test Sensitivity with Standard Error, n = 1250",
                                    x ="Proportion", y = "Avg. Test Sensitivity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()



#F1 score

#N = 500
mean_test_f1_500
#standard error
se_f1_500 = sqrt(var(mean_test_f1_500, na.rm=T))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_f1_500 + se_f1_500 < 1, mean_test_f1_500 + se_f1_500, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_f1_500,
  lower = mean_test_f1_500 - se_f1_500,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//500//test_f1.png")
ggplot(df, aes(proportions, mean_test_f1_500)) + 
  geom_point() + geom_line() + labs(title="Test f1 with Standard Error, n = 500",
                                    x ="Proportion", y = "Avg. Test f1") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 750
mean_test_f1_750
#standard error
se_f1_750 = sqrt(var(mean_test_f1_750, na.rm=T))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_f1_750 + se_f1_750 < 1, mean_test_f1_750 + se_f1_750, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_f1_750,
  lower = mean_test_f1_750 - se_f1_750,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//750//test_f1.png")
ggplot(df, aes(proportions, mean_test_f1_750)) + 
  geom_point() + geom_line() + labs(title="Test f1 with Standard Error, n = 750",
                                    x ="Proportion", y = "Avg. Test f1") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1000
mean_test_f1_1000
#standard error
se_f1_1000 = sqrt(var(mean_test_f1_1000))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_f1_750 + se_f1_1000 < 1, mean_test_f1_1000 + se_f1_1000, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_f1_1000,
  lower = mean_test_f1_1000 - se_f1_1000,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//1000//test_f1.png")
ggplot(df, aes(proportions, mean_test_f1_1000)) + 
  geom_point() + geom_line() + labs(title="Test f1 with Standard Error, n = 1000",
                                    x ="Proportion", y = "Avg. Test f1") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1250
mean_test_f1_1250
#standard error
se_f1_1250 = sqrt(var(mean_test_f1_1250))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_f1_1250 + se_f1_1250 < 1, mean_test_f1_1250 + se_f1_1250, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_f1_1250,
  lower = mean_test_f1_1250 - se_f1_1250,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//1250//test_f1.png")
ggplot(df, aes(proportions, mean_test_f1_1250)) + 
  geom_point() + geom_line() + labs(title="Test f1 with Standard Error, n = 1250",
                                    x ="Proportion", y = "Avg. Test f1") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()




#ACCURACY

#N = 500
mean_test_acc_500
#standard error
se_acc_500 = sqrt(var(mean_test_acc_500))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_acc_500 + se_acc_500 < 1, mean_test_acc_500 + se_acc_500, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_acc_500,
  lower = mean_test_acc_500 - se_acc_500,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//500//test_acc.png")
ggplot(df, aes(proportions, mean_test_acc_500)) + 
  geom_point() + geom_line() + labs(title="Test Accuracy with Standard Error, n = 500",
                                    x ="Proportion", y = "Avg. test accuracy") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 750
mean_test_acc_750
#standard error
se_acc_750 = sqrt(var(mean_test_acc_750))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_acc_750 + se_acc_750 < 1, mean_test_acc_750 + se_acc_750, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_acc_750,
  lower = mean_test_acc_750 - se_acc_750,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//750//test_acc.png")
ggplot(df, aes(proportions, mean_test_acc_750)) + 
  geom_point() + geom_line() + labs(title="Test Accuracy with Standard Error, n = 750",
                                    x ="Proportion", y = "Avg. Test accuracy") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1000
mean_test_acc_1000
#standard error
se_acc_1000 = sqrt(var(mean_test_acc_1000))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_acc_750 + se_acc_1000 < 1, mean_test_acc_1000 + se_acc_1000, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_acc_1000,
  lower = mean_test_acc_1000 - se_acc_1000,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//1000//test_acc.png")
ggplot(df, aes(proportions, mean_test_acc_1000)) + 
  geom_point() + geom_line() + labs(title="Test Accuracy with Standard Error, n = 1000",
                                    x ="Proportion", y = "Avg. Test accuracy") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1250
mean_test_acc_1250
#standard error
se_acc_1250 = sqrt(var(mean_test_acc_1250))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_test_acc_1250 + se_acc_1250 < 1, mean_test_acc_1250 + se_acc_1250, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_test_acc_1250,
  lower = mean_test_acc_1250 - se_acc_1250,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//test metrics//Confidence interval plots//1250//test_acc.png")
ggplot(df, aes(proportions, mean_test_f1_1250)) + 
  geom_point() + geom_line() + labs(title="Test Accuracy with Standard Error, n = 1250",
                                    x ="Proportion", y = "Avg. Test accuracy") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()





#VALIDATION METRICS


#SPECIFICITY FIRST


#N = 500

mean_val_specificity_500
#standard error
se_spec_500 = sqrt(var(mean_val_specificity_500))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_specificity_500 + se_spec_500 < 1, mean_val_specificity_500 + se_spec_500, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_specificity_500,
  lower = mean_val_specificity_500 - se_spec_500,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//500//val_spec.png")
ggplot(df, aes(proportions, mean_val_specificity_500)) + 
  geom_point() + geom_line() + labs(title="Validation Specificity with Standard Error, n = 500",
                                    x ="Proportion", y = "Avg. Validation Specificity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 750
mean_val_specificity_750
#standard error
se_spec_750 = sqrt(var(mean_val_specificity_750))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_specificity_750 + se_spec_750 < 1, mean_val_specificity_750 + se_spec_750, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_specificity_750,
  lower = mean_val_specificity_750 - se_spec_750,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//750//val_spec.png")
ggplot(df, aes(proportions, mean_val_specificity_750)) + 
  geom_point() + geom_line() + labs(title="Validation Specificity with Standard Error, n = 750",
                                    x ="Proportion", y = "Avg. Validation Specificity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1000
mean_val_specificity_1000
#standard error
se_spec_1000 = sqrt(var(mean_val_specificity_1000))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_specificity_1000 + se_spec_1000 < 1, mean_val_specificity_1000 + se_spec_1000, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_specificity_1000,
  lower = mean_val_specificity_1000 - se_spec_1000,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//1000//val_spec.png")
ggplot(df, aes(proportions, mean_val_specificity_1000)) + 
  geom_point() + geom_line() + labs(title="Validation Specificity with Standard Error, n = 1000",
                                    x ="Proportion", y = "Avg. Validation Specificity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1250
mean_val_specificity_1250
#standard error
se_spec_1250 = sqrt(var(mean_val_specificity_1250))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_specificity_1250 + se_spec_1250 < 1, mean_val_specificity_1250 + se_spec_1250, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_specificity_1250,
  lower = mean_val_specificity_1250 - se_spec_1250,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//1250//val_spec.png")
ggplot(df, aes(proportions, mean_val_specificity_1250)) + 
  geom_point() + geom_line() + labs(title="Validation Specificity with Standard Error, n = 1250",
                                    x ="Proportion", y = "Avg. Validation Specificity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()




#SENSITIVITY

#N = 500
mean_val_sensitivity_500
#standard error
se_sens_500 = sqrt(var(mean_val_sensitivity_500))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_sensitivity_500 + se_sens_500 < 1, mean_val_sensitivity_500 + se_sens_500, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_sensitivity_500,
  lower = mean_val_sensitivity_500 - se_sens_500,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//500//val_sens.png")
ggplot(df, aes(proportions, mean_val_sensitivity_500)) + 
  geom_point() + geom_line() + labs(title="Validation Sensitivity with Standard Error, n = 500",
                                    x ="Proportion", y = "Avg. Validation Sensitivity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 750
mean_val_sensitivity_750
#standard error
se_sens_750 = sqrt(var(mean_val_sensitivity_750))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_sensitivity_750 + se_sens_750 < 1, mean_val_sensitivity_750 + se_sens_750, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_sensitivity_750,
  lower = mean_val_sensitivity_750 - se_sens_750,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//750//val_sens.png")
ggplot(df, aes(proportions, mean_val_sensitivity_750)) + 
  geom_point() + geom_line() + labs(title="Validation Sensitivity with Standard Error, n = 750",
                                    x ="Proportion", y = "Avg. Validation Sensitivity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1000
mean_val_sensitivity_1000
#standard error
se_sens_1000 = sqrt(var(mean_val_sensitivity_1000))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_sensitivity_750 + se_sens_1000 < 1, mean_val_sensitivity_1000 + se_sens_1000, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_sensitivity_1000,
  lower = mean_val_sensitivity_1000 - se_sens_1000,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//1000//val_sens.png")
ggplot(df, aes(proportions, mean_val_sensitivity_1000)) + 
  geom_point() + geom_line() + labs(title="Validation Sensitivity with Standard Error, n = 1000",
                                    x ="Proportion", y = "Avg. Validation Sensitivity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1250
mean_val_sensitivity_1250
#standard error
se_sens_1250 = sqrt(var(mean_val_sensitivity_1250))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_sensitivity_1250 + se_sens_1250 < 1, mean_val_sensitivity_1250 + se_sens_1250, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_sensitivity_1250,
  lower = mean_val_sensitivity_1250 - se_sens_1250,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//1250//val_sens.png")
ggplot(df, aes(proportions, mean_val_sensitivity_1250)) + 
  geom_point() + geom_line() + labs(title="Validation Sensitivity with Standard Error, n = 1250",
                                    x ="Proportion", y = "Avg. Validation Sensitivity") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()



#F1 score

#N = 500
mean_val_f1_500
#standard error
se_f1_500 = sqrt(var(mean_val_f1_500, na.rm=T))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_f1_500 + se_f1_500 < 1, mean_val_f1_500 + se_f1_500, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_f1_500,
  lower = mean_val_f1_500 - se_f1_500,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//500//val_f1.png")
ggplot(df, aes(proportions, mean_val_f1_500)) + 
  geom_point() + geom_line() + labs(title="Validation f1 with Standard Error, n = 500",
                                    x ="Proportion", y = "Avg. Validation f1") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 750
mean_val_f1_750
#standard error
se_f1_750 = sqrt(var(mean_val_f1_750, na.rm=T))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_f1_750 + se_f1_750 < 1, mean_val_f1_750 + se_f1_750, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_f1_750,
  lower = mean_val_f1_750 - se_f1_750,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//750//val_f1.png")
ggplot(df, aes(proportions, mean_val_f1_750)) + 
  geom_point() + geom_line() + labs(title="Validation f1 with Standard Error, n = 750",
                                    x ="Proportion", y = "Avg. Validation f1") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1000
mean_val_f1_1000
#standard error
se_f1_1000 = sqrt(var(mean_val_f1_1000))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_f1_750 + se_f1_1000 < 1, mean_val_f1_1000 + se_f1_1000, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_f1_1000,
  lower = mean_val_f1_1000 - se_f1_1000,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//1000//val_f1.png")
ggplot(df, aes(proportions, mean_val_f1_1000)) + 
  geom_point() + geom_line() + labs(title="Validation f1 with Standard Error, n = 1000",
                                    x ="Proportion", y = "Avg. Validation f1") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1250
mean_val_f1_1250
#standard error
se_f1_1250 = sqrt(var(mean_val_f1_1250))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_f1_1250 + se_f1_1250 < 1, mean_val_f1_1250 + se_f1_1250, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_f1_1250,
  lower = mean_val_f1_1250 - se_f1_1250,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//1250//val_f1.png")
ggplot(df, aes(proportions, mean_val_f1_1250)) + 
  geom_point() + geom_line() + labs(title="Validation f1 with Standard Error, n = 1250",
                                    x ="Proportion", y = "Avg. Validation f1") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()




#ACCURACY

#N = 500
mean_val_acc_500
#standard error
se_acc_500 = sqrt(var(mean_val_acc_500))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_acc_500 + se_acc_500 < 1, mean_val_acc_500 + se_acc_500, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_acc_500,
  lower = mean_val_acc_500 - se_acc_500,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//500//val_acc.png")
ggplot(df, aes(proportions, mean_val_acc_500)) + 
  geom_point() + geom_line() + labs(title="Validation Accuracy with Standard Error, n = 500",
                                    x ="Proportion", y = "Avg. validation accuracy") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 750
mean_val_acc_750
#standard error
se_acc_750 = sqrt(var(mean_val_acc_750))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_acc_750 + se_acc_750 < 1, mean_val_acc_750 + se_acc_750, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_acc_750,
  lower = mean_val_acc_750 - se_acc_750,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//750//val_acc.png")
ggplot(df, aes(proportions, mean_val_acc_750)) + 
  geom_point() + geom_line() + labs(title="Validation Accuracy with Standard Error, n = 750",
                                    x ="Proportion", y = "Avg. Validation accuracy") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1000
mean_val_acc_1000
#standard error
se_acc_1000 = sqrt(var(mean_val_acc_1000))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_acc_750 + se_acc_1000 < 1, mean_val_acc_1000 + se_acc_1000, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_acc_1000,
  lower = mean_val_acc_1000 - se_acc_1000,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//1000//val_acc.png")
ggplot(df, aes(proportions, mean_val_acc_1000)) + 
  geom_point() + geom_line() + labs(title="Validation Accuracy with Standard Error, n = 1000",
                                    x ="Proportion", y = "Avg. Validation accuracy") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()

#N = 1250
mean_val_acc_1250
#standard error
se_acc_1250 = sqrt(var(mean_val_acc_1250))
#make sure that the upper bound of the confidence interval is STRICTLY <= 1 by truncating it:
upper_bound = ifelse(mean_val_acc_1250 + se_acc_1250 < 1, mean_val_acc_1250 + se_acc_1250, 1)

df <- data.frame(
  x = proportions,
  y_pred = mean_val_acc_1250,
  lower = mean_val_acc_1250 - se_acc_1250,
  upper = upper_bound)

png(file = "C://Users//John//Desktop//Research Project//Binary Project//R stuff//graphs//validation metrics//Confidence interval plots//1250//val_acc.png")
ggplot(df, aes(proportions, mean_val_f1_1250)) + 
  geom_point() + geom_line() + labs(title="Validation Accuracy with Standard Error, n = 1250",
                                    x ="Proportion", y = "Avg. Validation accuracy") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3) + 
  scale_x_continuous(breaks = proportions[seq(1, length(proportions), 2)]) 
dev.off()






