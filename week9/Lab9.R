############ Lab9/ PSTAT 126 #############
########## TA: Nhan Huynh ################

################# Model selection method ####################

# For this exercise you will perform model selection using the pima dataset in the faraway package.  Use glucose  as the outcome variable, and age, bmi, diabetes, diastolic, and insulin as the possible predictors.  Before performing the analysis, restrict the dataset to non-zero values on all variables.
data("pima",package = "faraway")
newpima<- subset(pima,(glucose>0)&(age>0)&(bmi>0)&(diabetes>0)&(diastolic>0)&(insulin>0))
# we only need to use a certain columns in the new data set:
newpima<- newpima[,c("glucose","age","bmi","diabetes","diastolic","insulin")]

# Step 1: Fit a first-order model that contains all the predictors (without the interaction). This can be considered as our baseline model. 
fit1<- lm(glucose~.,data=newpima)
summary(fit1)
# what do we see in this output? overall, the linear relationship is significant. For each single t test, partial p-value indicates that given other predictors in the model, bmi and diabetes are not significant (Recall that for partial p-value, order doesn't matter).

# Now, we're going to check the significance of each variable using the order we enter into the model (now, we study sequential p-value):
anova(fit1)
# Given the order we enter into the model: age, bmi, and insulin are highly significant; diabetes and diastolic are marginally significant. 

# Step 2: Let's fit a model that contains all possible 2-way interaction terms. Note: we only consider 2-way interactions for the sake of simplicity. 
fit.full<- lm(glucose~.^2,data=newpima)
summary(fit.full)

# now, using anova to compare fit1 (first-order model) and fit.full to study the significance of interaction terms in the model. If we prefer fit1 using this F test, interactions are not significant. If we prefer fit.full, it indicates that there is at least one 2-way interaction term is significant; or the model should include interactions between predictors. The first-order model alone is not good enough. 
anova(fit1,fit.full)
# Since p-value for this F test is small --> we prefer model with interaction terms. Now, what we have to do is figure out which models (with interaction terms) is the best one. To do this, we use the idea of stepwise regression approach. 

# Step 3: Let's try stepwise regression using backward elimination. The idea behind this approach is pretty simple. 
# Note: for stepwise regression, it uses a criteria called AIC for model selection. Model with smaller AIC value should be preferred. 
# Start with a full model, at each step, it drops a variable out of the model, re-fit the the data and calculate AIC value. Then, compared all models and pick the one with smallest AIC value.
# Now, start with the model in the above step, repeat the whole procedure until AIC value can be reduced anymore or there is no variable to be dropped. 
fit.back<-step(fit.full,direction = "backward")
summary(fit.back) 
# this is the best model using stepwise regression, specifically backward elimination. 

# Another approach is to try stepwise regression using forward selection. 
# Start with a model without any predictors: first, add one variable at a time and calculate AIC value. Pick model that has the greatest reduction in AIC from the null model.
# Repeat the whole procedure until AIC value cannot be reduced anymore, or there is no other variable to be added into the model.

# first, we fit the null model:
fit.null<- lm(glucose~1,data=newpima)
fit.forward<- step(fit.null,scope=list(lower=fit.null,upper=fit.full),direction="forward")
# scope argument gives the range of models to consider; the smallest model is null model and largest model is the fit.back. 

## Note: let's look at fit.forward and fit.backward:
fit.forward
fit.back
# these two models give us two different results. What should we do?
# if the fit.forward and fit.back are nested model, we can use F test
# if they are not nested, we can pick model with smaller AIC value.
anova(fit.forward,fit.back)
# prefer fit.back using F test. 