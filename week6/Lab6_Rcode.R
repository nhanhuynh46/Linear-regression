################ PSTAT 126/ Multiple linear regression #################
############### Lab 6/ TA: Nhan Huynh ##################################


# 1. Open the 'pima' data in the 'faraway' package:
data("pima",package = "faraway")

# 2. Create a new dataset (name it newpima) that uses the subset command to remove values of zero on any of the four variables (diastolic, age, bmi, and insulin).
newpima<- subset(pima,(diastolic>0)&(age>0)&(bmi>0)&(insulin>0))

# 3. Generate a scatterplot matrix for the four variables (diastolic, age, bmi, and insulin).  What do you see in the plots of diastolic against each of the three predictors? 
# Note: this step belongs to data analysis (before you build the linear model)

# we can use pairs() in R to create multiple scatterplots between the predictors and the response variable; 
# if you dont want to use this function, we can also use plot() and repeat this function multiple times
pairs(diastolic~age+bmi+insulin,data=newpima)

# or:
par(mfrow=c(3,1)) # create 3 windows in one figure to display all of plots; these plots will be presented in 3 rows ; if you write par(mfrow=c(1,3)) --> plots will be presented in 1 rows and 3 columns. Try it out at home!
plot(diastolic~age,data=newpima)
plot(diastolic~bmi,data=newpima)
plot(diastolic~insulin,data=newpima)

# these plots will give us the idea of the linear relationship between diastolic and predictors: age, bmi, and insulin.

# 4. Fit a linear model (name it fitnewpima) that predicts diastolic from age, bmi, and insulin.
fitnewpima<- lm(diastolic~age+bmi+insulin,data=newpima)

# 5. Read the summary output of fitnewpima:
summary(fitnewpima)

##################### how to we read this output?

# a. The estimated values of the parameters can be obtained from 'Estimate' column.
  # estimated value of beta_1 (parameter associates with age) is 0.349
  # estimated value of beta_3 (parameter associates with insulin) is -0.003

# b. for each predictor, we can perform a single t-test to test the significance between its linear relationship with the response. 
  # e.g: single t test to test linear relationship betwee bmi and diastolic. 
        # H_0: Beta_2=0 vs. H_a: Beta_2 is not 0.
        # t_statistic=6.199; under the null, t_statistic follows t distribution with df=n-p=393-4=389; p-value is small --> reject the null.
        # What is the conclusion from this t-test? Given that age and insulin in the model, the linear relationship between astolic and insulin is not significant with level of significance of 5%. 

# c. The result of overall F test: F_statistic=26.62 (=MS_model/MSE); under the null, it follows F distribution with df1=3 (p-1=4-1) and df2=389 (n-p=393-4); p-value of this test is small --> we have strong evidence to suggest that overall, the linear relatinoship between response and the predictors is significant.

# d. We can also obtain the coefficient of determination: R^2=0.1703--> about 17% of the total variation in diastolic can be explained by its linear relationship with age, bmi, and insulin.
# note: we will learn how to use adjusted R-squared later on (R_a=0.1639)
###############################

# 6. Generate the following data displays:
# a. Residuals plot with fitted values on the X axis, residuals on the Y axis and a horizontal line at zero
resd<- residuals(fitnewpima)
pred<- fitted(fitnewpima)

# prior, we setup the display figure such that we can display multiple plots in one figure--> change it back to normal setting:
par(mfrow=c(1,1))

plot(pred,resd,xlab="predicted value",ylab="residual",main="residual versus predicted value",pch=19)
abline(h=0)
# what do we observe from this plot?
# points are randomly scattered around x axis.
# points are bounded between horizontal bands --> constant variance assumption is hold. 

## additional stuff (just for fun)
## using this plot, we can spot some outliers in the data, how to identify them?
identify(pred,resd,2)
# the 8th and 58th observations are outliers in this case. 

# b. QQ normal plot, with QQ line
qqnorm(resd,pch=19)
qqline(resd)

# c.	Histogram of residuals
hist(resd,breaks=40,main="histogram of residual")

## we can see that in both QQ plot and histogram: outliers are lying on the left tail.

# d. Scatterplot of residuals (test for independence)
plot(resd,main="Scatterplot of residuals",pch=19)
abline(h=0)

############### additional diagnostic plots (might help with your project or future preference )##################
## we can also take a look at the scatterplot between residuals and the predictors:

# residuals vs. age:
plot(newpima$age,resd,xlab="age",main="residuals vs. age") # the pattern is random. That's good! --> it indicates there is no high-ordered relationship between diastolic and age. 

# residuals vs. bmi
plot(newpima$bmi,resd,xlab="bmi",main="residuals vs. bmi") # the pattern is random as well. 

# residuals vs. insulin
plot(newpima$insulin,resd,xlab="insulin",main="residuals vs. insulin") # the pattern is random. 



