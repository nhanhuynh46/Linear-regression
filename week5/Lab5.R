################# PSTAT126/ Lab5 ####################
###### Spring 2017/ TA: Nhan Huynh    ###############

# The 'USArrests' dataset of the 'datasets' package contains crime statistics and population composition for each of the 50 US states from the year 1973.  For each state, the dataset contains the number of arrests (per 100,000 in population size) for Murder, Assault and Rape, along with the variable UrbanPop - the percent of the state’s population that lives in an urban area.

data("USArrests",package = "datasets")
? USArrests

# 1. Fit a linear model with Assault (number of assault) as response variable and UrbanPop (percent urban population).
fit<- lm(Assault~UrbanPop,data=USArrests)
summary(fit)

# to obtain the residuals of a fitted model, use: residuals() function
obs.error<- residuals(fit)
# to obtain the fitted value, use: fitted() function
pred.value<- fitted(fit)

# from p-value in single t-test and overall F test in summary output: what is your conclusion?
# at level of significance of 5%, the linear relationship between Assault and UrbanPop is not significant. 

# 2. Check the linearity between Assault and UrbanPop by plotting the scatterplot:
plot(Assault~UrbanPop,data=USArrests,xlim=c(0,100),ylim=c(0,400),main="Scatterplot between UrbanPop and Assault")
# note: xlim and ylim argument in the above --> custom the range of x-axis and y-axis. I want my plot to have x-axis from 0 to 100 and y-axis from 0 to 400; if you dont add these arguments, range of the axes are automatically the range of response and predictor variables. 

# what do we observe in this scatterplot?
# the linear pattern between x and y is not obvious to see.

# note: we can also plot residuals versus predictor to check for non-linearity. In fact, this method is much more preferred in practice. However, it is an advanced method and you don't need to worry about it at this point. 
plot(USArrests$UrbanPop,obs.error,xlab="UrbanPop",ylab="Residual",main="Residual vs. UrbanPop")
# in your future project, feel free to use this method to check for non-linearity if you prefer. 

# 3. Check for constant variance of the errors (or constant variance of response variable):
# create residual vs. fitted scatterplot:
plot(pred.value,obs.error)
abline(h=0)

# for constant variance, we expect to see these data points to be bounded by "invisible" horizontal bands. 
# it doesn't seem so in this plot --> it indicates that constant variance assumption is violated in this case. 

# 4. Independence of the errors (or independence of y_i observations)
# If errors are independent, then one observation does not influence another observation in the dataset.  Dependent (or correlated) errors often occur when observations are taken physically near each other, or close together in time.  One method of testing this is to plot the residuals according to the order that the observations appear in the dataset.  If data points that are next to each other in the plot have similar errors, then they are not independent (also called correlated errors) - Prof. Gross's explanation in lab document.
plot(obs.error)

# are the points randomly scattered?
# NOT REALLY --> it seems like altogether, they form a pattern --> indicates that independence assumption is violated. 

# 5. Normality assumption of the errors (or normality assumption of the response variable):

# option1: Use QQ plot to compare the quantiles of our residuals (observed quantiles) with the quantiles from normal distribution (theoretical quantiles). If residuals are indeed from normal ditribution, the observed quantiles will be closed to the theoretical quantiles --> expect to see these points to be close to QQline (x=y line)
qqnorm(obs.error) # create Q-Q plot
qqline(obs.error) # add Q-Q line in QQ plot
# S-shape and the points in the tail are further away from QQline --> heavy tail distribution.

# option2: use histogram:
hist(obs.error,breaks=20)

################ Now, repeat the whole thing using Rape as predictor and Assault as response variable #########
fit2<- lm(Assault~Rape,data=USArrests)
summary(fit2)

# using summary output, the linear relationship between Rape and Assault is highly significant. 

# 1. Linearity assumption: 
plot(Assault~Rape,data=USArrests,xlim=c(0,50),ylim=c(0,400),main="Assault vs. Rape",pch=19,col="red")
# there is a clear pattern of linearity between assault and rape. The more number of rape arrest cases, the more number of assault in urban areas.

# Note: scatterplot between response variable and predictor to detect linearity pattern is more appropriate to be done in data exploration process (before building the model). Later on, you'll learn that we will use overall F test to "officially" test the overall linear relationship between response variable and our predictors (when we have multiple predictors in the data).

# 2. Constant variance of the errors: 

# obtain the residual values:
res.fit2<- residuals(fit2)
# obtain the fitted values:
pred.fit2<- fitted(fit2)

# residual vs. predicted scatterplot:
plot(res.fit2~pred.fit2,xlab="fitted value",ylab="residual",main="residual vs. fitted value")
abline(h=0)
# it looks like constant variance assumption is not hold in this case (the larger value of fitted value, the smaller variance)

# 3. Independence of the errors:
plot(res.fit2,ylab="residual")
# points are randomly scattered --> independence assumption remains true. 

# 4. Normality assumption:
qqnorm(res.fit2)
qqline(res.fit2)
# it has an S-shape --> heavy-tailed distribution --> normality assumption is violated. 

hist(res.fit2,breaks=30,main="histogram of residual")
