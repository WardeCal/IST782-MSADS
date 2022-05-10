#install.packages("caret")
#install.packages("rpart")
#install.packages("modeldata")
#install.packages("dplyr")
#install.packages("xgboost")
#install.packages("DiagrammeR")
#install.packages("fastDummies")
#install.packages("randomForrest")
#install.packages('viridis')
#install.packages('hrbrthemes')
#install.packages('ggthemes')

library(highcharter)
library(neuralnet)
library(ggplot2)
library(randomForest)
library(caret)
library(rpart)
library(modeldata)
library(dplyr)
library(xgboost)
library(DiagrammeR)
library(fastDummies)
library(viridis)
library(hrbrthemes)
library(ggthemes)
adult.data <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data"))
#adult.test <- read.csv(url("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test"))

summary(adult.data)
head(adult.data)
tail(adult.data)


col_names <- cbind("age", "workclass", "fnlwgt", "education", "educationNum", "maritalStatus", "occupation", "relationship", "race", "sex",
                   "capitalGain", "capitalLoss", "hoursPerWeek", "nativeCountry", "Value")

col_names

colnames(adult.data) <- col_names
head(adult.data)
summary(adult.data)


# narrow down data to complete records

adult.data <- na.omit(adult.data)
head(adult.data)
str(adult.data)

adult.data$workclass <- factor(adult.data$workclass)
adult.data$education <- factor(adult.data$education)
adult.data$maritalStatus <- factor(adult.data$maritalStatus)
adult.data$occupation <- factor(adult.data$occupation)
adult.data$relationship <- factor(adult.data$relationship)
adult.data$race <- factor(adult.data$race)
adult.data$sex <- factor(adult.data$sex)
adult.data$nativeCountry <- factor(adult.data$nativeCountry) 
adult.data$Value <- factor(adult.data$Value)

str(adult.data)
#adult.dataClean <- adult.data[complete.cases(adult.data),]
#head(adult.dataClean)
# show distribution of age
hist(adult.data$age)

# visualize some of the columns

hchart(adult.data$Value)
hchart(adult.data$workclass)
hchart(adult.data$occupation)
hchart(adult.data$education)
hchart(adult.data$nativeCountry)
hist(adult.data$hoursPerWeek)


#### Plot our independent vs dependent variables
#### Just an example for now, WIP
gWC <- ggplot(adult.data, aes(x = Value, fill = Value)) +
  geom_bar(position = 'dodge', stat = 'count') +
  stat_count(geom = 'text', color = 'black', 
             aes(label = ..count.., vjust = -0.5)) +
  facet_wrap(~workclass) +
  ggtitle('Income by Work Class') 
  # + theme_fivethirtyeight()

gWC

gMS <- ggplot(adult.data, aes(x = Value, fill = Value)) +
  geom_bar(position = 'dodge', stat = 'count') +
  stat_count(geom = 'text', color = 'black', 
             aes(label = ..count.., vjust = -0.5)) +
  facet_wrap(~maritalStatus) +
  ggtitle('Income by Marital Status') +
  theme_fivethirtyeight()

gMS

gO <- ggplot(adult.data, aes(x = Value, fill = Value)) +
  geom_bar(position = 'dodge', stat = 'count') +
  stat_count(geom = 'text', color = 'black', 
             aes(label = ..count.., vjust = -0.5)) +
  facet_wrap(~occupation) +
  ggtitle('Income by Occupation') +
  theme_fivethirtyeight()

gO

gEd <- ggplot(adult.data, aes(x = Value, fill = Value)) +
  geom_bar(position = 'dodge', stat = 'count') +
  stat_count(geom = 'text', color = 'black', 
             aes(label = ..count.., vjust = -0.5)) +
  facet_wrap(~education) +
  ggtitle('Income by Education') +
  theme_fivethirtyeight()

gEd


# Getting train and test data for all models
adult.data$USAorNot <- as.integer(as.numeric(adult.data$nativeCountry))
adult.data$USAorNot <- ifelse(adult.data$USAorNot == 40, 1,0)
head(adult.data)

adult.data <- adult.data[,-8]
adult.data <- adult.data[,-5]
adult.data <- adult.data[,-14]
head(adult.data)

set.seed(1234)
indices <- sample(nrow(adult.data), 0.70 * nrow(adult.data))
train <- adult.data[indices, ]
test <- adult.data[-indices, ]

# Linear Regression Model *has issues

#regmodel <- lm(Value ~ ., data = adult.data)

# Trying to create a neural net, however this has categorical values throughout the data so these all need to be changed
# binary *has issues
set.seed(10)
log.neural <- neuralnet(Value ~ ., data = adult.data, hidden = 1, act.fct="logistic")


# Creating a Bayesian binary logistic regression model *Has issues
#probmodel <- train(Value ~ ., data = adult.data, method = "bayesglm") # not good for data with more than two classes, as this one has
#summary(probmodel)

knnmodel <- train(Value ~ ., data = adult.data, method = "knn", preProcess = c("center", "scale"))
#knnmodel

rf <- randomForest(Value ~ ., data = train)
rf
varImpPlot(rf)

predrf = predict(rf, newdata=test[,-13])
summary(predrf)
comptablerf <- data.frame(test[,13],predrf)
head(comptablerf)

confusionMatrix(comptablerf$test...13., comptablerf$predrf)


# XGBOOST
y <- as.numeric(train$Value) - 1
x <- train %>% select(-Value)
str(x)
#transform factor into dummy variables -----NEED TO RUN ALL THIS CODE ABOVE AND BELOW TO CREATE A TEST DF FOR NEURAL NETWORK TESTING
#install.packages("fastDummies")

X <- dummy_cols(x, remove_first_dummy = TRUE)
head(X)
X <- X %>% select(c(-workclass, -education, -maritalStatus, -occupation, -race, -sex, -nativeCountry))
head(X)

#set paramaters
params <- list(set.seed = 10, eval_metric = "auc", objective = "binary:logistic")

xg <- xgboost(data = as.matrix(X), label = y, params = params, nrounds = 200, verbose = 1)
#shap values
xgb.plot.shap(data = as.matrix(X), model = xg, top_n = 5)
summary(xg)
importance_matrix <- xgb.importance(model = xg)
xgb.plot.importance(importance_matrix[1:10])
xgb.plot.tree(model = xg, n_first_tree = 2)

y1 <- as.numeric(test$Value) - 1
x1 <- test %>% select(-Value)
X1 <- dummy_cols(x1, remove_first_dummy = TRUE)
head(X1)
X1 <- X1 %>% select(c(-workclass, -education, -maritalStatus, -occupation, -race, -sex, -nativeCountry))
head(X1)

predxg <- predict(xg, as.matrix(X1))
predxg <- round(predxg, 0)
head(predxg)
xgtable <- data.frame(y1, predxg)
#xgtable <- as.factor(xgtable)
str(xgtable)


xgtable$actualValue <- ifelse(xgtable$y1 == 1, '>=50K', '<50K')
xgtable$predValue <- ifelse(xgtable$predxg == 1, '>=50K', '<50K')
xgtable <- xgtable[,-1:-2]
head(xgtable)
str(xgtable)
xgtable$predValue <- as.factor(xgtable$predValue)
xgtable$actualValue <- as.factor(xgtable$actualValue)
confusionMatrix(xgtable$actualValue, xgtable$predValue)

# I am going to try a nueral network model here, now that we have a data set with all 1/0s
# going to create a new data frame with the Y and X data


################################################# CAL - Changing US and other countries to 1 and 0
hchart(adult.data$nativeCountry)
adult.data2 <- data.frame(adult.data)
adult.data2$USAorNot <- as.integer(as.numeric(adult.data2$nativeCountry))
adult.data2$USAorNot <- ifelse(adult.data2$USAorNot == 40, 1,0)
head(adult.data2)
hchart(adult.data2$USAorNot)
us_ratio <- sum(adult.data2$USAorNot)/nrow(adult.data2)
us_ratio *100
USNative <- sum(adult.data2$USAorNot)
NotNative <- nrow(adult.data2) - USNative
native <- c(USNative, NotNative)
pie(native, labels = c("US Native - 89.58%", "Not US Native - 10.42%"), main = "US Native or Not Population")

adult.data2$WhiteorNot <- as.integer(as.numeric(adult.data2$race))
adult.data2$WhiteorNot <- ifelse(adult.data2$WhiteorNot == 5, 1,0)
head(adult.data2)
hchart(adult.data2$WhiteorNot)
White_ratio <- sum(adult.data2$WhiteorNot)/nrow(adult.data2)
White_ratio *100
wRace <- sum(adult.data2$WhiteorNot)
oRace <- nrow(adult.data2) - wRace
Race <- c(wRace, oRace)
pie(Race, labels = c("White - 85.43%", "Other Race - 14.57%"), main = "Race Population")


adult.data2$MaleorNot <- as.integer(as.numeric(adult.data2$sex))
adult.data2$MaleorNot <- ifelse(adult.data2$MaleorNot == 2, 1,0)
head(adult.data2)
hchart(adult.data2$MaleorNot)
Male_ratio <- sum(adult.data2$MaleorNot)/nrow(adult.data2)
Male_ratio *100
male <- sum(adult.data2$MaleorNot)
female <- nrow(adult.data2) - male
malefemale <- c(male, female)
str(malefemale)
pie(malefemale, labels = c("Male - 66.92%", "Female - 33.08%"), main = "Male/Female Population")


#Smaller data set to work with
adult.data2 <- data.frame(adult.data$Value, adult.data$relationship,adult.data$capitalGain, adult.data$age, adult.data$fnlwgt, adult.data$USAorNot)
colnames(adult.data2)<- c("value", "relationship", "capitalGain", "age", "fnlwgt", "USAorNot")
adult.data2$value <- as.integer((as.numeric(adult.data2$value)))
adult.data2$value <- ifelse(adult.data2$value == 2,1,0) # if it is <=50 it is a 0 and if >50 it is a 1 to get lm and rf to work
head(adult.data2)
str(adult.data2)
#New train/test datta with adult.data2
set.seed(1234)
indices <- sample(nrow(adult.data2), 0.70 * nrow(adult.data2))
train2 <- adult.data2[indices, ]
test2 <- adult.data2[-indices, ]
str(train2)
str(test2)
#Linear model
regmodel2 <- lm(value ~ ., data = adult.data2)
summary(regmodel2) #Rsquared value of .2455

#Testing lm on whole data set
str(adult.data)
head(adult.data)
adult.data$Value <- as.integer((as.numeric(adult.data$Value)))
adult.data$Value <- ifelse(adult.data$Value == 2,1,0) # if it is <=50 it is a 0 and if >50 it is a 1
regmodel <- lm(Value~., data=adult.data)
summary(regmodel) #Rsquared vale of .3672

#Correlation matrix on all the variables that can be used
str(adult.data)
cor(adult.data[,c("age","fnlwgt","educationNum","capitalGain","capitalLoss","hoursPerWeek")], use="complete")
