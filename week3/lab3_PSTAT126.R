##################    TA: Nhan Huynh  #######################
################## PSTAT 126/ Lab 3 #########################

# I won't upload my R script on GauchoSpace. Prof. Gross will upload a separate file of R code for the labs sometimes in the future. Note that his R code won't have much comments for you to follow. 
# You can email this R script to yourself and directly work with it in your laptop during the lab.
# If you work with this R script in the lab computer, please don't change anything. 

#### Goals:
# 1. Learn how to test hypotheses for the regression slope using t-test and ANOVA methods
# 2. Learn how to perform these tests using R

#### We've been looking at the pima data set for the past two weeks. In lab3 handout, Prof. Gross provides codes with comments on the fitted linear model between bmi and diastolic. Please read the handout for more details (I don't want to repeat what have been shown in the handout; you can read it on your own).
#### In this lab, I will only focus on the second excersise using the uswages data set. 
#### Exercise: explore the relationship between education and weekly wages in the 'uswages' data set from the 'faraway' package. 

# outcome variable: wage
# predictor variable: level of education
 
# 1. Open the uswages dataset from the faraway package:
library("faraway")
data(uswages)

# alternative way to call out the data set without using library function is:
data(uswages, package = "faraway") # add an additional argument to specify that uswages is stored in faraway package. Note: either way,you have to install the package farway first. 

# 2. Create a simple linear regression using education (educ) as predictor and weekly wage (wage) as an outcome variable:
# note: in practice, you should always examine the distribution of education and wage before building the model

fit<- lm(wage~educ,data=uswages)
# to see the output of the model --> use summary function
summary(fit)

# 3. Recall: last week, we've learned how to read the estimated value of the intercept and the slope, along with the value of the coefficient of determination (R^2). This week, we shall continue to analyze the fitted model by examining the single t-test for the population regression coeffient (unknown parameter beta_1)

 # a. State the null and the alternative hypotheses:
      # H_0: beta_1=0
      # H_a: beta_1 is not 0
 # b. Use the summary of the linear model to test these hypotheses: 
 # c. What value of t did you obtain for the regression slope that predicts wage from level of education? t=11.46
 # d. What is the p-value for the slope? p-value is very close to 0
 # e. Draw a statistical conclusion regarding the null hypothesis above and state why we reject the null hypothesis? Since p-value is less than level of significance --> we reject the null. When we reject the null, it indicates that the true value of beta_1 is not 0 (in other words, it is significant) --> the linear regression between weekly wage and level of education is significant. 

# 4. We will know repeat the hypothesis test using the ANOVA method. 
 
 # a. Generate the ANOVA output in R
anova(fit)
 # b. From this output, what is the value of SS_total? 
SS_total<- 26066994+396613654
SS_total
 # c. What is the value of df_total?
df_total<- 1+1998
df_total
 # d. Using the above results to complete the ANOVA table. 
 # e. Draw a statistical conclusion and state why --> From the output, p-value of this hypothesis test is very small (close to 0) --> reject the null. The slope is significant. In other words, the linear relationship between weekly wage and level of education is significant. 

############################# end of lab 3 ######################












