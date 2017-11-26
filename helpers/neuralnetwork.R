
##### ETL
regressionData <- fullData[c("Contract_Expiry", "Rating", "Height", "Weight", "Age", "ValueUnified", "WageUnified")]
regressionData$Height <- gsub("[^0-9]", "", regressionData$Height)
regressionData$Weight <- gsub("[^0-9]", "", regressionData$Weight)

regressionData$Height <- as.numeric(as.character(regressionData$Height))
regressionData$Weight <- as.numeric(as.character(regressionData$Weight))

regressionData$ValueUnified <- as.numeric(regressionData$ValueUnified)

##### Regression
set.seed(1000)
library(MASS)
library(neuralnet)

index <- sample(1:nrow(regressionData),round(0.75*nrow(regressionData)))

maxs <- apply(regressionData, 2, max) 
mins <- apply(regressionData, 2, min)

scaled <- as.data.frame(scale(regressionData, center = mins, scale = maxs - mins))

valueDataset <- scaled %>% select(-WageUnified)
wageDataset  <- scaled %>% select(-ValueUnified)

trainValue <- valueDataset[index,]
testValue <- valueDataset[-index,]

nValue <- names(trainValue)
fValue <- as.formula(paste("ValueUnified ~", paste(nValue[!nValue %in% "ValueUnified"], collapse = " + ")))
nnValue <- neuralnet(fValue,data=trainValue,hidden=c(6,3),linear.output=F)

trainWage <- wageDataset[index,]
testWage <- wageDataset[-index,]

nWage <- names(trainWage)
fWage <- as.formula(paste("WageUnified ~", paste(nWage[!nWage %in% "WageUnified"], collapse = " + ")))
nnWage <- neuralnet(fWage,data=trainWage,hidden=c(6,3),linear.output=F)

getValuePrediction <- function(contract_expiry, rating, height, weight, age) {
  predictionData <- data.frame(contract_expiry, rating, height, weight, age)
  maxs <- apply(predictionData, 2, max) 
  mins <- apply(predictionData, 2, min)
  scaledPredictionData <- as.data.frame(scale(predictionData, center = mins, scale = maxs - mins))
  
  pr.nn <- neuralnet::compute(nnValue,predictionData[1:5])
  pr.nn_ <- pr.nn$net.result*(max(regressionData$ValueUnified)-min(regressionData$ValueUnified))+min(regressionData$ValueUnified)
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


testingtheprediction <- getValuePrediction(2018, 50, 180, 80, 20)
testingtheprediction2 <- getWagePrediction(2018, 50, 180, 80, 20)