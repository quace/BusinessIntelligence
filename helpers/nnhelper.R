

getPredictionParams <- function(fullData)
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

return (regData)