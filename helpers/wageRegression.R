# ETL
regressiondata <- read.csv("Wageregression.csv")
regressiondata <- subset(regressiondata, WageUnified < 150000 & WageUnified > 0)

regressiondata2 <- read.csv("Valueregression.csv")
regressiondata2 <- subset(regressiondata2, ValueUnified < 40000000 & ValueUnified > 0)



# knn regression
library(dplyr)
library(class)
library(MASS)
library(kknn)

set.seed(2017)

index <- sample(1:nrow(regressiondata),round(0.75*nrow(regressiondata)))
index2 <- sample(1:nrow(regressiondata2),round(0.75*nrow(regressiondata2)))

train <- regressiondata[index,]
test <- regressiondata[-index,]

train2 <- regressiondata2[index,]
test2 <- regressiondata2[-index,]

# trainingknn <- train.kknn(WageUnified ~ Rating + Weak_foot + Skill_Moves + Potential, data = regressiondata,test = test, kmax = 25, kernel = c("triangular", "rectangular", "epanechnikov", "optimal"))
# plot(trainingknn)
# saveRDS(trainingknn, "trainingknn.rds")
# trainingknn2 <- train.kknn(ValueUnified ~ Rating + Weak_foot + Skill_Moves + Potential, data = regressiondata2,test = test2, kmax = 25, kernel = c("triangular", "rectangular", "epanechnikov", "optimal"))
# plot(trainingknn2)
# saveRDS(trainingknn2, "trainingknn2.rds")

trainingknn <- readRDS("helpers/trainingknn.rds")
trainingknn2 <- readRDS("helpers/trainingknn2.rds")

getWagePrediction <- function(Rating, Weak_foot, Skill_Moves, Potential){
  valuestopredict <- data.frame(Rating, Weak_foot, Skill_Moves, Potential)
  valuestopredict$prediction <- predict(trainingknn,valuestopredict)
  predictedval <- prediction[1]
  return(predictedval)
}
test <- getWagePrediction(70,3,3,70)

prediction <- predict(trainingknn,regressiondata)
test <-as.numeric(regressiondata$prediction[4])