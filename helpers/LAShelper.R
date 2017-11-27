#Loan and Sell helper

#suggest which players to loan: low rating, high potential
calculateWhichPlayersToLoan <- function(table){
  
  #calculate the means
  meanPotential <- mean(table$Potential)
  meanRating <- mean(table$Rating)
  
  #if player has a rating below the mean and a potential above the mean -> loan
#  table$Loan[((table$Rating < meanRating) && (table$Potential > meanPotential))] <- as.character(icon('check-square'))
  table$Loan[(table$Rating < meanRating)] <- as.character(icon('check-square'))  
  table$Loan[(table$Potential <= meanPotential)] <- as.character(icon('square-o'))  
  
  return (table)
}


#For higher attacking technique:
#-boost stamina
#-get faster
#get stronger
#master the pass
checkAttackingTechnique <- function(table){
  table$reasonsToSellAttacking <- 0
  
  meanStamina <- mean(table$Stamina)
  meanSpeed <- mean(table$Speed)
  meanStrength <- mean(table$Strength)
  meanAttackingPos <- mean(table$Attacking_Position)
  meanPassing <- mean(table$Passing)
  
  #sell if attacking pos < mean
  table$reasonsToSellAttacking[(table$Attacking_Position < meanAttackingPos)] <- table$reasonsToSellAttacking[(table$Attacking_Position < meanAttackingPos)] + 1 
  
  #or if min 2 of those other attributes are below the mean
  table$numberBelowAverage[table$Stamina < meanStamina] <- table$numberBelowAverage[table$Stamina < meanStamina] + 1
  table$numberBelowAverage[table$Speed < meanSpeed] <- table$numberBelowAverage[table$Speed < meanSpeed] + 1
  table$numberBelowAverage[table$Strength < meanStrength] <- table$numberBelowAverage[table$Strength < meanStrength] + 1
  table$numberBelowAverage[table$Passing < meanPassing] <- table$numberBelowAverage[table$Passing < meanPassing] + 1
  
  table$reasonsToSellAttacking[table$numberBelowAverage > 2] <- table$reasonsToSellAttacking[table$numberBelowAverage > 2] + 1
  
  table$reasonsToSell[table$reasonsToSellAttacking > 0] <- table$reasonsToSell[table$reasonsToSellAttacking > 0] + 1
  table$Reason[table$reasonsToSellAttacking > 0] <- paste(table$Reason[table$reasonsToSellAttacking > 0] ,as.character(icon("bullseye")),sep=" ")
  
  return(table)
}

checkWage <- function(table){
  table$PredictedWage <- getWagePrediction(table$Contract_Expiry,table$Rating,table$Height,table$Weight,table$Age)
  table$reasonsToSell[table$WageUnified > table$PredictedWage] <- table$reasonsToSell[table$WageUnified > table$PredictedWage] + 1
  table$Reason[table$WageUnified > table$PredictedWage]  <- paste(table$Reason[table$WageUnified > table$PredictedWage] ,as.character(icon("credit-card")),sep=" ")
  return(table)
}

checkValue <- function(table){
  table$PredictedValue <- getValuePrediction(table$Contract_Expiry,table$Rating,table$Height,table$Weight,table$Age)
  table$reasonsToSell[table$ValueUnified > table$PredictedValue] <- table$reasonsToSell[table$ValueUnified > table$PredictedValue] + 1
  table$Reason[table$ValueUnified > table$PredictedValue]  <- paste(table$Reason[table$ValueUnified > table$PredictedValue] ,as.character(icon("money")),sep=" ")
  return(table)
}

checkContract <- function(table){
  currentYear <- as.integer(format(Sys.Date(), "%Y"))
  table$reasonsToSell[abs(table$Contract_Expiry-currentYear) < 2] <- table$reasonsToSell[abs(table$Contract_Expiry-currentYear) < 2] + 1
  table$Reason[abs(table$Contract_Expiry-currentYear) < 2]  <- paste(table$Reason[abs(table$Contract_Expiry-currentYear) < 2],as.character(icon("ban")),sep=" ")
  return(table)
}

checkAge <- function(table){
  table$reasonsToSell[table$Age > 30] <- table$reasonsToSell[table$Age > 30] + 1
  table$Reason[table$Age > 30] <- paste(table$Reason[table$Age > 30],as.character(icon("graduation-cap")),sep=" ")
  return(table)
}

#suggest which players to sell: min 2 reasons why 
calculateWhichPlayersToSell <- function(table){
  table$reasonsToSell <- 0
  table$Reason <- as.character('')
  
  #attacking technique is low
  table <- checkAttackingTechnique(table)
  
  #over peak potential 
  
  #wage > predicted wage (you overpay the player)
  #table <- checkWage(table)
  
  #value  > predicted value (you can make extra profit)
  #table <- checkValue(table)
  
  #contract_expiry - current year < 2j
  table <- checkContract(table)
  
  #old people
  table <- checkAge(table)
  
  
  #threshold is 2 atm
  table$Sell[(table$reasonsToSell > 1)] <- as.character(icon('check-square'))  
  table$Reason[(table$reasonsToSell < 2)]  <- as.character('')
  
  return(table)
}



constructLoandSellTable <- function(club){
  #first filter to players of this club
  loanAndSellTable <- filter(fullData, Club == club)
  
  #load.fontawesome()
  #fa <- fontawesome(c('fa-check-square', 'fa-square-o'))
  
  
  
  loanAndSellTable$Loan <- as.character(icon('square-o')) #'<i class="fa fa-check-square" aria-hidden="true"></i>'
  loanAndSellTable <- calculateWhichPlayersToLoan(loanAndSellTable)
  
  loanAndSellTable$Sell <- as.character(icon('square-o'))
  loanAndSellTable <- calculateWhichPlayersToSell(loanAndSellTable)
  loanAndSellTable <- loanAndSellTable %>% select("Photo","Name","Nationality","Age","Rating","Potential","Loan","Sell","Reason")
  
  return(loanAndSellTable)
}
