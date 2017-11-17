####### PSTAT 126/ Spring 2017 #######
####### TA: Nhan Huynh ###############

# Goals:
# 1. Learn how to conduct a one-tailed test, and a test of a speficied hypothesized value, for the slope, using R.
# 2. Learn how to generate and interpret a confidence interval and a prediction invertal for a predicted response in R. 

##### Excerise 1 ######

# A researcher has studied the relationship between movie ticket prices and movie theater attendance. She studied 15 theater, and measured the avarege ticket price, and the average percentage of empty seats in the theater one week. She found a sample slope of 15%, and a standard error of the slope of 2.6.

# 1. The researcher wants to prove that for each dollar increase in ticket prices, the percentage of empty seats will increase by more than 10%. 
#. State the null and alternative hypotheses

#. Calculate t-statistic for this test. 

t.stat<- (15-10)/2.6

#. Determine the t-critical value for this one-tailed test:
# recall from previous lectures: t critical is from t-distribution with df=n-2
? qt
qt(0.95,13)
# compare t.stat and the critical value we just obtain:
t.stat<qt(0.95,13)
# since t statistic is grater than t-critical value --> we reject the null.
# conclusion:...

###### Excercise 2 #######
 
# 1. Open the 'pima' dataset from the 'faraway' package --> remove zero values --> generate the summary of the linear model that predicts diastolic from bmi:
library(faraway)
data(pima)

newpima<- subset(pima,bmi>0 & diastolic >0)
fit<- lm(diastolic~bmi,data=newpima)
summary(fit)

# 2. Using the estimates of the slope and intercept from R output, calculate the predicted diastolic blood pressure for an individual with bmi=29

ypred<- 55.48694 + 0.51989*29
ypred

# 3. Repeat this calculation using prediction command in R. 
? predict
predict(fit,data.frame(bmi=29))

# 4. Calculate 95% confidence interval for the mean predicted blood pressure of all individuals with bmi=29. 
predict(fit, data.frame(bmi=29),interval="confidence",level=.95)

# 5. Calculate 95% prediction interval for the predicted blood pressure of an individual with bmi=29. 
predict(fit,data.frame(bmi=29),interval="prediction",level=0.95)

# 6. Compare confidience intervals in question 4 and question 5. Why are they different?

# 7. Now, repeat question 4 and 5 using confidence interval of 99%. 

