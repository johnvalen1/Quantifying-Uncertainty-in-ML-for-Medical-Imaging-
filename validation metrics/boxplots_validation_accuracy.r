models_results = read.csv('pneumonia_models.csv', header=T)
attach(models_results)
names(models_results)

sample_sizes = c(500, 1000, 1500, 2000)
proportions = c(0.01, seq(0.05, 0.5, 0.05))
length(proportions)
#each case had a model trained 20 times
#first 20 cases (n=500, p=1%):


#first sample size (of 500):
#this will create a list of lists.
cases = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 500 & proportion==proportions[i])
  validation_accuracy=case$Valid_Accuracy
  print(validation_accuracy)
  cases[i] = list(validation_accuracy)
}
cases

#if for example we want the first case: n = 500, p = 0.01
cases[1]
#if we want n = 500 & p = 0.50
cases[11]

boxplot(cases,ylab="Validation accuracy", main="n=500, all proportions", xaxt='n',xlab="Proportion",cex=0.5)
axis(1, at=1:11, labels=proportions[1:11])

mean_validation_per_case = c()
for (validation_scores in cases){
  mean_validation_per_case = c(mean_validation_per_case, mean(validation_scores,na.rm=T))
}
mean_validation_score=mean(mean_validation_per_case,na.rm=T)

abline(a= mean_validation_score, b=0, col="red")






#second sample size (of 1000):
#this will create a list of lists.
cases = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 1000 & proportion==proportions[i])
  validation_accuracy=case$Valid_Accuracy
  print(validation_accuracy)
  cases[i] = list(validation_accuracy)
}
cases


boxplot(cases,ylab="Validation accuracy", main="n=1000, all proportions", xaxt='n',xlab="Proportion",cex=0.5)
axis(1, at=1:11, labels=proportions[1:11])

mean_validation_per_case = c()
for (validation_scores in cases){
  mean_validation_per_case = c(mean_validation_per_case, mean(validation_scores,na.rm=T))
}
mean_validation_score=mean(mean_validation_per_case,na.rm=T)

abline(a= mean_validation_score, b=0, col="red")






#third sample size (of 1500):
#this will create a list of lists.
cases = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 1500 & proportion==proportions[i])
  validation_accuracy=case$Valid_Accuracy
  print(validation_accuracy)
  cases[i] = list(validation_accuracy)
}
cases


boxplot(cases,ylab="Validation accuracy", main="n=1500, all proportions", xaxt='n',xlab="Proportion",cex=0.5)
axis(1, at=1:11, labels=proportions[1:11])

mean_validation_per_case = c()
for (validation_scores in cases){
  mean_validation_per_case = c(mean_validation_per_case, mean(validation_scores,na.rm=T))
}
mean_validation_score=mean(mean_validation_per_case,na.rm=T)

abline(a= mean_validation_score, b=0, col="red")




#third sample size (of 2000):
#this will create a list of lists.
cases = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 2000 & proportion==proportions[i])
  validation_accuracy=case$Valid_Accuracy
  print(validation_accuracy)
  cases[i] = list(validation_accuracy)
}
cases


boxplot(cases,ylab="Validation accuracy", main="n=2000, all proportions", xaxt='n',xlab="Proportion",cex=0.5)
axis(1, at=1:11, labels=proportions[1:11])

mean_validation_per_case = c()
for (validation_scores in cases){
  mean_validation_per_case = c(mean_validation_per_case, mean(validation_scores,na.rm=T))
}
mean_validation_score=mean(mean_validation_per_case,na.rm=T)

abline(a= mean_validation_score, b=0, col="red")





