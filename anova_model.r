models_results = read.csv('pneumonia_models.csv', header=T)
attach(models_results)
names(models_results)

sample_sizes = c(500, 1000, 1500, 2000)
proportions = c(0.01, seq(0.05, 0.5, 0.05))
length(proportions)

n = sample_size
p = proportion


#build a linear model to predict ... test accuracy?

#first we categorize our data.
models_results$sample_size_token = ifelse(n==500, 'n1', 
                                          ifelse(n==1000, 'n2', 
                                                 ifelse(n==1500, 'n3', 
                                                        ifelse(n==2000, 'n4',''))))

models_results$proportion_token = ifelse(p==0.01, 'p1', 
                                          ifelse(p==0.05, 'p2', 
                                                 ifelse(p==0.10, 'p3', 
                                                        ifelse(p==0.15, 'p4',
                                                               ifelse(p==0.20, 'p5',
                                                                      ifelse(p==0.25, 'p6',
                                                                             ifelse(p==0.30, 'p7',
                                                                                    ifelse(p==0.35, 'p8',
                                                                                           ifelse(p==0.40, 'p9',
                                                                                                  ifelse(p==0.45, 'p10',
                                                                                                         ifelse(p==0.50, 'p11',
                                                                                                                'NA')))))))))))
n = models_results$sample_size_token
p = models_results$proportion_token
y = models_results$Test_Sensitivity
#---- now sample size and proportion have been made categorical.
#our anova model for test accuracy
anova_model_test_accuracy = lm(y ~ n + p + n:p)
summary(anova_model_test_accuracy)
anova_model_test_accuracy$coefficients
#a numerical regression? Define a beta regression for this... test accuracy <= 1
install.packages("betareg")
library("betareg")
n = models_results$sample_size
p = models_results$proportion

#fits the model: test_accuracy = constant + a1*sample_size + a2*proportion + a3*interaction
regression_model_test_accuracy = betareg(y ~ n + p + n:p)
summary(regression_model_test_accuracy)
