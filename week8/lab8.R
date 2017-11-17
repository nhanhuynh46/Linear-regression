################### PSTAT 126/ Lab8 #####################
############### TA: Nhan Huynh ##########################

####### 1. Import gpa data set in R #########

# change the working directory to the folder where we store the data set:
setwd("~/Dropbox/UCSB Classes/TA/PSTAT 126/week8")
list.files()

study<- read.table("gpadata.txt",header=TRUE)

study<- as.data.frame(study) # convert the file to data frame in R

# some basic information of the data set:
names(study) # variables in the data 

# contains 3 variables: gpa (range: 0.50-4.00); entrance (college entrance exam score; range: 14.00-35.00); and declared status (2 levels: 0=undeclared and 1=declared).
dim(study)
# data contains 120 observations (freshman).

attach(study) # we can directly work with variables in study data frame without using '$'

# for example, we've learned to call out a variable using the '$':
summary(study$entrance)
# now, after using the function attach, use 'entrance' directly:
summary(entrance)

######### 2. Data analysis (before building model) ###########

### create scatterplots between variables in model
pairs(gpa~entrance+declared)
### what do we observe in these scatterplots? 
# (a) gpa and entrance --> overall, there is a positive correlation between gpa and entrance
# (b) gpa and declared --> can't detect any pattern as declared has only 2 levels: 0 and 1. Note: it's not helpful to create a scatterplot between reponse and categorical predictor.

## we're going to explore the interaction between 2 predictors: entrance and declared (on gpa)
## idea: scatterplot between entrance and gpa for different groups of declared:

# scatterplot between gpa vs. entrance when value of declared is 0:
plot(entrance[declared==0],gpa[declared==0],col="red",pch=19,lwd=2,xlab="entrance",ylab="gpa",xlim=c(14,42),main="gpa vs. extrance score exam for each group of declared")
# on the same figure, scatterplot between gpa vs. entrance when value of declared is 1:
points(entrance[declared==1],gpa[declared==1],col="blue",pch=25,lwd=2)
# add the legend:
legend("topright",c("undeclared","declared"),col=c("red","blue"),pch=c(19,25))

# Question: is there a strong evidence of interaction between entrace and declared status?
# in this case, pay attention to the linear slope between entrance and gpa when declared==0 and when declared==1
# it seems like, the red group has a higher slope than the blue group. 

## let's add linear slopes into the scatterplot we created earlier:
## I'm going to build two simple linear regression: 
## (a) model1: gpa ~ entrance when all declared values are 0
## (b) model2: gpa ~ entrance when all declared values are 1
abline(lm(gpa[declared==0]~entrance[declared==0]),col="red")
abline(lm(gpa[declared==1]~entrance[declared==1]),col="blue",lty=2)
# Confirm that: the linear dependence of gpa on entrance exam is different for each group of declared --> strongly reflexes the interaction between entrance and declared on gpa. 


######### 3. Building the linear model with gpa as a response variable; entrance and declared as predictors:
fit<- lm(gpa~entrance+declared)
summary(fit)
# interpret the result of this model:
# from single t-test: entrance is significant but declared is not. 


# now, let add the interaction between entrance and declared:
fit2<- lm(gpa~entrance*declared) # creating a new model with interaction term; use asterisk symbol '*' between the predictors
summary(fit2)

# note: there are multiple way to add the interaction term, you can even do this:
fit2<- update(fit,.~.+entrance*declared) # update fit by adding the interaction term
summary(fit2)

# what do we observe in this case?
# now, entrance is not significant, declared is significant, and interaction between declared and entrance is not significant. 

### let's compare fit (reduced model/smaller model) and fit2 (full model/bigger model); fit is nested inside fit2 because all terms in fit are within fit2.
### perfrom F test to compare reduced model and full model
anova(fit,fit2,test="F")

# since p-value for this test is less than level of significance --> reject the null --> full model is preferred. 
# in other words, model with interaction terms does a better job at fitting the data. 




