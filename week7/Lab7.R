################ PSTAT 126/ Lab 7 ###################
########### Ta: Nhan Huynh ##########################

######## Exercise 1: Some basic matrix algebra
# how to input a matrix in R?

A<- matrix(c(3,5,1),nrow=1,ncol=3,byrow=TRUE) 
# create a 1 by 3 matrix
# enter the value of element using c(); in this case the list contains 3,5,and 1
# matrix is filled by rows using the argument: byrow=TRUE
# note: at default, byrow=FALSE --> the matrix is filled by column
A

B<- matrix(c(6,2,9),nrow=1,ncol=3,byrow=TRUE)
B

C<- matrix(c(2,4,6,8),nrow=2,byrow=TRUE) 
C

# what happens if we don't add the argument byrow=TRUE?
D1<- matrix(c(2,5,4,2,6,0,0,1,8),nrow=3)
D1

# transpose of D1:
D2<- t(D1)
D2

E<- matrix(c(5,0,3,1,7,5),nrow=3)
E

# Matrix multiplication in R using: %*%:
A%*%t(B)
t(B)%*%A

D%*%E

# inverse of a square matrix:
solve(C)
# determinant of a square matrix:
det(C)

########## Exercise 2: how to read a file into R

# 1. check the directory you are at:
getwd()

# 2. set the directory to the folder where you store the file:
setwd("~/Dropbox/UCSB Classes/TA/PSTAT 126/week7")

# 3. check the list of files in the folder:
list.files()

# 4. read the dwaine.txt:
dwaine<- read.table("Dwaine.txt",header = TRUE) # import text file in R; read in the header
View(dwaine)

# 5. summary of this data:
summary(dwaine)

########### Exercise 3: 
# 1. Open the pima data set in the faraway package
data("pima",package = "faraway")

# we're going to build several linear models using pima data set:

# 2. Create a new dataset (name it newpima) that uses the subset command to remove values of zero on any of five variables (diastolic, glucose, insulin, bmi, and age).
newpima<- subset(pima,diastolic>0 & glucose>0 & insulin>0 & bmi>0 & age>0)

dim(pima)
dim(newpima)

# 3. Fit the full linear model predicting diastolic from glucose, insulin, bmi, and age.  Be sure to enter the predictors in that order.
fit.full<- lm(diastolic~glucose+insulin+bmi+age,data=newpima)

# 4. Generate the summary output for the fitnewpima linear model. What is R2 for this model? Is the overall p-value significant for this model?
summary(fit.full)

# R^2=0.1791 --> interpretation: about 18% of the total variation in the response can be explained by its linear relationship with the predictors. 
# overall p-value is small --> strong evidence to reject that null that there is no linear relationship between diastolic and ALL the predictors. 

########## Partial sum of squares (Type 3 sum of squares/ Order doesn't matter)
# Partial sum of squares account for the distribution of the predictor given that other predictors in the model. 
# from the summary output, for each single t-test to test the significance of the slope parameter, p-values for these single t-tests are partial p-values. 

# for example: p-value for t-test to test if the slope of insulin is significant. Since p-value=0.12> alpha --> fail to reject the null. Conclusion: given that other predictors in the model, the linear relationship between insulin and diastolic is not significant.

# examine other p-values --> bmi and age are highly significant/ glucose is marginally significant.

# we can also obtain partial sum of squares using Anova function in library car:
library("car")
Anova(fit.full,type="III")

# if we comapare p-value from Anova function and p-value from summary of the model --> they are the same.

########## Sequential sum of squares (Type 1 sum of squares/ Order does matter)
## to find sequential sum of squares, using anova function in R:
anova(fit.full)
# the p-value in this case is sequential p-value.

# For example: given that glucose is already in the model, insulin is not significant as p-value is pretty large. 
# note: Compre p-value in this output with p-value in model output --> they are different. 

########## Testing the significance of a subset of predictors 

# 1.	Fit a reduced model (name it fit.reduced) that predicts diastolic from BMI and age.  What is R2 for this model?  Is the overall p-value significant for this model?
fit.reduced<- lm(diastolic~bmi+age,data=newpima)

summary(fit.reduced)
# the overall p-value is small--> overall, the linear relationship between the response variable and two predictors are significant.
# R^2=17.08% --> about 17% of the total variation in the reponse variable can be explained by the linear relationship between diastolic and bmi and age. 

# 2. Compare this R2 to the R2 obtained for the fit.full model above?  What is the difference in R2?
# Recall: R^2 in fit1 is 18% while R^2 in the reduced model is 17% --> it's always true that the more predictors you have in the model, the larger value of R^2. 

# 3. Use the anova command to compare the two models.  What is the SS(glucose,insulin|age,bmi)? What is the p-value? 
anova(fit.reduced)

# How to perform F test to compare fit.reduced and fit.full?
anova(fit.reduced,fit.full,test="F")
# since p-value is greater than level of significance --> fail to reject the null --> the reduced model is preferred. 







