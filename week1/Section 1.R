########### TA: Nhan Huynh ###########################
########## PSTAT 126/Spring 2017/Lab1 ################

# Note: when you turn in your assignment (must be hardcopy), make sure to include:
#   1. Name/Perm ID
#   2. Course (PSTAT126)/Lab setion
#   3. Homework #
#   4. Date

########## Some R code examples using pima data set ##########

# pima data set is available in 'faraway' package. To access this data, we first need to install the package.

# this is a comment

# 1. install a package in R. 
? install.packages

# install 'faraway' package in R:
install.packages("faraway")
# after installing, we also need to call out this package before sucessfully accessing:
library("faraway")

# note: once you finish installing a package, no need to re-install the package again. To get access of the package, only need to run library('name.of.package')

# 2. Read 'pima' data into R:
data(pima)
# or: data("pima")

# Question: what is this data about? what information does it contain?
? pima

# this is study on 768 adult female Pima Indians living near Phoenix. 
# how to obtain names of variables (columns' names) in the data?
colnames(pima)
# or:
names(pima)
# note: read help file to learn more information about each variable

# View this data set:
View(pima)

# 3. Summarize the pima data:
? summary
help(summary)
summary(pima)

# what if we only want to summarize a specific variable instead of the whole data?
# ex: summarize bmi variable:
summary(pima[,c("bmi")])
# or:
summary(pima$bmi)

# range of bmi: 0 to 67.10 --> at least one value of bmi is 0. 

# sort bmi variable to easily spot which one has 0 value:
sort(pima$bmi)
# look inside this sorted list: 11 values of bmi are 0. In fact, these are our missing values in pima data set. 

# note: missing values are not sucessfully recorded into the data set; or these values got dropped out during measurement process; or these are hard to obtain. Notation of missing value is NA in R. 

# how to set 0 values to NA for bmi variable?
pima$bmi[pima$bmi==0]<- NA
# if you think the above line is compliated, think like this: first we need to call out bmi variable within pima df; then we need to find which values within each bmi are 0; then replace these 0 values with NA.

# what happens if we re-sort bmi after replacing 0s with NAs?
sort(pima$bmi)
# what do you observe?

# do the same thing for glucose variable:
# summrize glucose:
summary(pima$glucose)

# replace 0 values to NA for glucose:
pima$glucose[pima$glucose==0]<- NA

# 4. Visualize bmi variable by creating a histogram:
? hist
hist(pima$bmi)

# how to adjust the histogram with labels, title, and number of bins?
hist(pima$bmi,main="Histogram of bmi",xlab="bmi",breaks=20)

# now, create a scatterplot of bmi vs. glucose:
? plot
plot(pima$bmi,pima$glucose)
# or:
plot(glucose~bmi,data=pima,main="scatter plot of bmi vs. glucose")

# how to add the regression line into the existing plot?
abline(lm(glucose~bmi,data=pima))

# note: in the above code, we use 2 functions: lm() and abline() at once. Function lm() helps build regression model between glucose (response variable) and bmi; abline() adds a regression line from lm() into the plot. 

