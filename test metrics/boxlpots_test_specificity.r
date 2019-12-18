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
  test_accuracy=case$Test_Specificity
  print(test_accuracy)
  cases[i] = list(test_accuracy)
}
cases

#if for example we want the first case: n = 500, p = 0.01
cases[1]
#if we want n = 500 & p = 0.50
cases[11]

boxplot(cases,ylab="Test Specificity", main="n=500, all proportions", xaxt='n',xlab="Proportion",cex=0.5)
axis(1, at=1:11, labels=proportions[1:11])

mean_test_per_case = c()
for (test_scores in cases){
  mean_test_per_case = c(mean_test_per_case, mean(test_scores,na.rm=T))
}
mean_test_score=mean(mean_test_per_case,na.rm=T)

abline(a= mean_test_score, b=0, col="red")






#second sample size (of 1000):
#this will create a list of lists.
cases = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 1000 & proportion==proportions[i])
  test_accuracy=case$Test_Accuracy
  print(test_accuracy)
  cases[i] = list(test_accuracy)
}
cases


boxplot(cases,ylab="Test accuracy", main="n=1000, all proportions", xaxt='n',xlab="Proportion",cex=0.5)
axis(1, at=1:11, labels=proportions[1:11])

mean_test_per_case = c()
for (test_scores in cases){
  mean_test_per_case = c(mean_test_per_case, mean(test_scores,na.rm=T))
}
mean_test_score=mean(mean_test_per_case,na.rm=T)
abline(a= mean_test_score, b=0, col="red")






#third sample size (of 1500):
#this will create a list of lists.
cases = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 1500 & proportion==proportions[i])
  test_accuracy=case$Test_Accuracy
  print(test_accuracy)
  cases[i] = list(test_accuracy)
}
cases


boxplot(cases,ylab="Test accuracy", main="n=1500, all proportions", xaxt='n',xlab="Proportion",cex=0.5)
axis(1, at=1:11, labels=proportions[1:11])

mean_test_per_case = c()
for (test_scores in cases){
  mean_test_per_case = c(mean_test_per_case, mean(test_scores,na.rm=T))
}
mean_test_score=mean(mean_test_per_case,na.rm=T)
abline(a= mean_test_score, b=0, col="red")





#final sample size (of 2000):
#this will create a list of lists.
cases = c()
for (i in 1:length(proportions)){
  case = subset(models_results, sample_size == 2000 & proportion==proportions[i])
  test_accuracy=case$Test_Accuracy
  print(test_accuracy)
  cases[i] = list(test_accuracy)
}
cases


boxplot(cases,ylab="Test accuracy", main="n=2000, all proportions", xaxt='n',xlab="Proportion",cex=0.5)
axis(1, at=1:11, labels=proportions[1:11])

mean_test_per_case = c()
for (test_scores in cases){
  mean_test_per_case = c(mean_test_per_case, mean(test_scores,na.rm=T))
}
mean_test_score=mean(mean_test_per_case,na.rm=T)
abline(a= mean_test_score, b=0, col="red")

