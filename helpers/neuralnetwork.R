library(dplyr)
library(stringr)
##### ETL

#fullData <- read.csv("MergedCompleteDataNEW.csv")

keep <- c("Contract_Expiry", "Rating", "Height", "Weight", "Age", "Potential", "Pace", "Shooting", "Passing", "Dribblingx","Defending","Physicality","GK_Score","Preffered_Position","ValueUnified", "WageUnified")
regressionData <- fullData[keep]
regressionData$Height <- gsub("[^0-9]", "", regressionData$Height)
regressionData$Weight <- gsub("[^0-9]", "", regressionData$Weight)

regressionData$Height <- as.numeric(as.character(regressionData$Height))
regressionData$Weight <- as.numeric(as.character(regressionData$Weight))

regressionData$ValueUnified <- as.numeric(regressionData$ValueUnified)
regressionData$Preffered_Position <- gsub("/"," ", regressionData$Preffered_Position)
regressionData$Position <- word(regressionData$Preffered_Position, 1)

GK <- c("GK")
DEF <- c("LB","CB","RB", "RWB", "LWB")
MF <- c("CDM", "CM", "CAM", "RM", "LM")
ATT <- c("RW", "LW", "CF", "ST")

keep2 <- c("Contract_Expiry", "Rating", "Height", "Weight", "Age", "Potential", "Pace", "Shooting", "Passing", "Dribblingx","Defending","Physicality","GK_Score","Position")
regData <- regressionData[keep2]
regData <- regData %>% mutate(GK_Bool = ifelse(regData$Position %in% GK,1,0))
regData <- regData %>% mutate(DEF_Bool = ifelse(regData$Position %in% DEF,1,0))
regData <- regData %>% mutate(MF_Bool = ifelse(regData$Position %in% MF,1,0))
regData <- regData %>% mutate(ATT_Bool = ifelse(regData$Position %in% ATT,1,0))
regData <- regData %>% mutate(Value = regressionData$ValueUnified)
regData <- regData %>% mutate(Contract_Expiry = Contract_Expiry - min(Contract_Expiry))
drop <- c("Position")
regData <- regData[,!(names(regData) %in% drop)]

##### Linear Regression

set.seed(2017)

library(MASS)

index <- sample(1:nrow(regressionData),round(0.75*nrow(regressionData)))

train <- regData[index,]
test <- regData[-index,]

lm.fit <- glm(Value~., data = train)
summary(lm.fit)
predictionofLinearModel <- predict(lm.fit,test)

MSEofLinearModel <- sum((predictionofLinearModel - test$Value)^2)/nrow(test)

##### Neural network

library(neuralnet)

maxs <- apply(regData, 2, max)
mins <- apply(regData, 2, min)

scaled <- as.data.frame(scale(regData, center = mins, scale = maxs - mins))

trainValue <- scaled[index,]
testValue <- scaled[-index,]

nValue <- names(trainValue)
fValue <- as.formula(paste("Value ~", paste(nValue[!nValue %in% "Value"], collapse = " + ")))
nnValue <- neuralnet(fValue, trainValue, hidden = c(12,12), threshold = 0.01,
                     stepmax = 1e+05, rep = 1, startweights = NULL,
                     learningrate.limit = NULL,
                     learningrate.factor = list(minus = 0.5, plus = 1.2),
                     learningrate=NULL, lifesign = "full",
                     lifesign.step = 1000, algorithm = "rprop+",
                     err.fct = "sse", act.fct = "logistic",
                     linear.output = TRUE, exclude = NULL,
                     constant.weights = NULL, likelihood = FALSE)

prNNValue <- compute(nnValue,testValue[,1:17])

predictionNNValues <- prNNValue$net.result*(max(regData$Value)-min(regData$Value))+min(regData$Value)
testValues <- (testValue$Value)*(max(regData$Value)-min(regData$Value))+min(regData$Value)

MSEofNN <- sum((testValues - predictionNNValues)^2)/nrow(testValue)

par(mfrow=c(1,2))

plot(test$Value,predictionNNValues,col='red',main='Real vs predicted NN',pch=18,cex=0.7)
abline(0,1,lwd=2)
legend('bottomright',legend='NN',pch=18,col='red', bty='n')

plot(test$Value,predictionofLinearModel,col='blue',main='Real vs predicted LM',pch=18, cex=0.7)
abline(0,1,lwd=2)
legend('bottomright',legend='LM',pch=18,col='blue', bty='n', cex=.95)

########################################
########################################
########################################

getValuePrediction <- function(contract_expiry, rating, height, weight, age, Potential, Pace, Shooting, Passing, Dribblingx,Defending,Physicality,GK_Score, GK_Bool, DEF_Bool, MF_Bool, ATT_Bool) {
  predictionData <- data.frame(contract_expiry, rating, height, weight, age, Potential, Pace, Shooting, Passing, Dribblingx,Defending,Physicality,GK_Score, GK_Bool, DEF_Bool, MF_Bool, ATT_Bool)
  
  scaledPredictionData <- as.data.frame(scale(predictionData, center = mins[1:17], scale = maxs[1:17] - mins[1:17]))
  
  pr.nn <- neuralnet::compute(nnValue,predictionData[,1:17])
  pr.nn_ <- pr.nn$net.result*(max(regData$Value)-min(regData$Value))+min(regData$Value)
  return(pr.nn_)
}

getWagePrediction <- function(contract_expiry, rating, height, weight, age) {
  predictionData <- data.frame(contract_expiry, rating, height, weight, age)
  maxs <- apply(predictionData, 2, max) 
  mins <- apply(predictionData, 2, min)
  scaledPredictionData <- as.data.frame(scale(predictionData, center = mins, scale = maxs - mins))
  
  pr.nn <- neuralnet::compute(nnWage,predictionData[1:5])
  pr.nn_ <- pr.nn$net.result*(max(regressionData$WageUnified)-min(regressionData$WageUnified))+min(regressionData$WageUnified)
  return(pr.nn_)
}

testprediction <- getValuePrediction(1,50,180,70,25,52,50,50,50,50,50,50,50,0,0,0,1)
