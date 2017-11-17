######### PSTAT 126/ Section 2 ############
######### TA: Nhan Huynh       ############


######### A. BMI and blood pressure ##########
## let's explore the simple linear regression of bmi as an predictor and diastolic blood pressure as an outcome variable in the pima in the faraway package. 

# to access the data set, call out the package faraway:
library(faraway)

# note: if you haven't installed the package, you need to install it first before calling it out, use: install.package() 
# then, call out data set pima:
data(pima)

## questions:

# 1. Not a question, but it's something you should pay attentiosn to
# dependent/response/outcome variable
# independent/covariate/predictor variable
# note: you should always distinguish between dependent and independent variable before building any predictive models. 

# 2. 
# a. Are there outliers on either variables? 
# we can examine the distribution of both variables to see if they contain outliers (Recall: for now, assume that outliers are data points further away from the bulk of the data set)

hist(pima$bmi,main="histogram of bmi",xlab="bmi",breaks=40)
# what do you observe in the histogram?
# note: I add the argument breaks=40 in order to make group of outliers easier to see. 

mean(pima$bmi) # average of bmi using function mean()
sd(pima$bmi) # sample standard deviation of bmi using function sd()
# recall: standard deviation measures the variation/dispersion of the data (how much spread out the distribution is)

hist(pima$diastolic,breaks=40,main="histogram of diastolic",xlab="diastolic")
# what do you observe in the histogram?

mean(pima$diastolic)
sd(pima$diastolic)

# b. How can we remove outliers from the analysis?
# there are several ways to do this.
# recall how to replace a value by NA value from last section 
# alternative method: use subset() 
? subset

newpima= subset(pima,(bmi>0)&(diastolic>0))
# check the dimension of pima (contains outliers) and newpima (no longer contains outliers) to see the difference:
dim(pima)
dim(newpima)
# from now on, we use newpima instead of pima

# go back and create histogram for diastolic and bmi using new data:
hist(newpima$bmi,breaks=40,main="histogram of bmi",xlab="bmi")
hist(newpima$diastolic,breaks=40,main="histogram of diastolic",xlab="diastolic")

# 3. 
# Are the data skewed? --> go back the histograms in question 2.

# 4. 
# Create scatterplot between bmi and diastolic. What does the plot tell us?
plot(diastolic~bmi,data=newpima,main="scatterplot between diastolic vs. bmi")

# 5. 
# Build linear regression model between bmi and diastolic:

# recall: to build linear regression, use lm()
lm(diastolic~bmi,data=newpima)

# to obtain the summary of the model we just built:
summary(model1)
# for now, only pay attention to the value of coefficients.
# what does the intercept of 55.5 tell us?
# what does the slope 0.52 tell us? 

## now, add the fitted straight line to the scatterplot:
abline(lm(diastolic~bmi,data=newpima))

# 6. 
# One of the summary output is R-squared. Find out what is the value of this statistic and interpret it. 
# note: R-square is also coefficient of determination. 




############ B. Education and US Wages ##############
## explore the simple linear regression of weekly wages (wage) as an outcome and years of education (educ) in the 'uswages' dataset in the faraway package. 
# call out this data:
data("uswages")

# if it is your first time seeing this data set, you can learn more about this data set using the command:
? uswages
# weekly wages of us male workers in 1988
dim(uswages)
# 2000 rows and 10 columns

# 1. 
# are there outliers on either variables? 
hist(uswages$wage,breaks=50,main="histogram of wage",xlab="wage")
mean(uswages$wage)
sd(uswages$wage)

hist(uswages$educ,breaks=20,main="histogram of education",xlab="education")
mean(uswages$educ)
sd(uswages$educ)

# 2.
# are the data skewed? 

# 3. Construct the scatter plot between wage and education. Describe the the relationship between them from this plot.
plot(uswages$educ,uswages$wage)

# 4. Construct the linear regression model.
fit2<- lm(wage~educ,data=uswages)
summary(fit2)

# 5.
# what does the intercept of 109.76 tell us?
# what does the slope of 38 tell us? 

# 6. 
# Obtain R^2 statistic from the output. Interpret it. 












