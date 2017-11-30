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
  table$numberBelowAverage <- 0
  
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
checkAttackingTechnique2 <- function(table){
  table$reasonsToSellAttacking <- 0
  table$numberBelowAverage <- 0
  
  meanStamina <- mean(table$Stamina)
  meanSpeed <- mean(table$Speed)
  meanStrength <- mean(table$Strength)
  meanAttackingPos <- mean(table$Attacking_Position)
  meanPassing <- mean(table$Passing)
  
  #buy if attacking pos > mean
  table$reasonsToSellAttacking[(table$Attacking_Position > meanAttackingPos)] <- table$reasonsToSellAttacking[(table$Attacking_Position > meanAttackingPos)] + 1 
  
  #or if min 2 of those other attributes are above the mean
  table$numberBelowAverage[table$Stamina > meanStamina] <- table$numberBelowAverage[table$Stamina > meanStamina] + 1
  table$numberBelowAverage[table$Speed > meanSpeed] <- table$numberBelowAverage[table$Speed > meanSpeed] + 1
  table$numberBelowAverage[table$Strength > meanStrength] <- table$numberBelowAverage[table$Strength > meanStrength] + 1
  table$numberBelowAverage[table$Passing > meanPassing] <- table$numberBelowAverage[table$Passing > meanPassing] + 1
  
  table$reasonsToSellAttacking[table$numberBelowAverage > 2] <- table$reasonsToSellAttacking[table$numberBelowAverage > 2] + 1
  
  table$reasonsToSell[table$reasonsToSellAttacking > 0] <- table$reasonsToSell[table$reasonsToSellAttacking > 0] + 1
  table$Reason[table$reasonsToSellAttacking > 0] <- paste(table$Reason[table$reasonsToSellAttacking > 0] ,as.character(icon("bullseye")),sep=" ")
  
  return(table)
}

checkWage <- function(table){
  table$reasonsToSell[table$WageUnified > (2*table$WagePrediction)] <- table$reasonsToSell[table$WageUnified > (2*table$WagePrediction)] + 1
  table$Reason[table$WageUnified > (2*table$WagePrediction)]  <- paste(table$Reason[table$WageUnified > (2*table$WagePrediction)] ,as.character(icon("credit-card")),sep=" ")
  return(table)
}

checkWage2 <- function(table){
  table$reasonsToSell[(2*table$WageUnified) < table$WagePrediction] <- table$reasonsToSell[(2*table$WageUnified) < table$WagePrediction] + 1
  table$Reason[(2*table$WageUnified) < table$WagePrediction]  <- paste(table$Reason[(2*table$WageUnified) < table$WagePrediction] ,as.character(icon("credit-card")),sep=" ")
  return(table)
}

checkValue <- function(table){
  table$reasonsToSell[table$ValueUnified > (1.5*table$ValuePrediction)] <- table$reasonsToSell[table$ValueUnified > (1.5*table$ValuePrediction)] + 1
  table$Reason[table$ValueUnified > (1.5*table$ValuePrediction)]  <- paste(table$Reason[table$ValueUnified > (1.5*table$ValuePrediction)] ,as.character(icon("money")),sep=" ")
  return(table)
}
checkValue2 <- function(table){
  table$reasonsToSell[(1.5*table$ValueUnified) < table$ValuePrediction] <- table$reasonsToSell[(1.5*table$ValueUnified) < table$ValuePrediction] + 1
  table$Reason[(1.5*table$ValueUnified) < table$ValuePrediction]  <- paste(table$Reason[(1.5*table$ValueUnified) < table$ValuePrediction] ,as.character(icon("money")),sep=" ")
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
checkAge2 <- function(table){
  table$reasonsToSell[table$Age < 23] <- table$reasonsToSell[table$Age < 23] + 1
  table$Reason[table$Age < 23] <- paste(table$Reason[table$Age < 23],as.character(icon("graduation-cap")),sep=" ")
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
  table <- checkWage(table)
  
  #value  > predicted value (you can make extra profit)
  table <- checkValue(table)
  
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



#set possible positions
# possiblePositions <- function(table){
#   table$Positions <- ""
#   for (i in 1:nrow(table)) {
#     prefPos <- unlist(strsplit(toString(table[i,]$Preffered_Position),"[/]"))
#     #extend the preferred positions with the current club position IF different
#     if(!(toString(table[i,]$Club_Position) %in% prefPos)){
#       prefPos <- c(prefPos,toString(table[i,]$Club_Position))
#     }
#     table[i,]$Positions <- paste(prefPos,collapse="/")
#   }
#   return (table)
# }

filterOnPosition <- function(table,position){
  table <- table%>% mutate(CanPlayPosition = ifelse(position %in% strsplit(toString(Positions),"/"),TRUE, FALSE))
  
  
  # table$CanPlayPosition <- FALSE
  # for (i in 1:nrow(table)) {
  #   prefPos <- unlist(strsplit((table[i,]$Positions),"[/]"))
  #   if(position %in% prefPos){
  #     table[i,]$CanPlayPosition <- TRUE
  #   }
  #  
  # }
  
  onlyPlayersOnPosition <- filter(table, CanPlayPosition)
  
  return (onlyPlayersOnPosition)
}


calculateWhichPlayersToBuy <- function(table){
  table$reasonsToSell <- 0
  table$Reason <- as.character('')
  
  #attacking technique is high
  table <- checkAttackingTechnique2(table)
  
  #peak potential has yet to come
  
  #wage < predicted wage (you overpay the player)
  table <- checkWage2(table)
  
  #value  < predicted value (you can make extra profit)
  table <- checkValue2(table)
  
  #contract_expiry - current year < 2j
  table <- checkContract(table)
  
  #young people
  table <- checkAge2(table)
  
  
  #threshold is 2 atm
  table$Sell[(table$reasonsToSell > 1)] <- as.character(icon('check-square'))  
  table$Reason[(table$reasonsToSell < 2)]  <- as.character('')
  
  #filter and show only the players to sell
  onlyPlayersToSell <- filter(table, reasonsToSell > 1)
  
  return(onlyPlayersToSell)
}

#Get which players to buy
#@param club : the club that is buying the player
#@param position: OPTIONAL position you wanna fill
#@param pricemin & pricemax : price range in k
constructAcquireTable <- function(club,position,pricemin, pricemax){
  pricemin = pricemin*1000
  pricemax = pricemax*1000
  
  
  #first filter out the players that are already members of the club
  acquireTable <- filter(fullData, Club != club)
  
  acquireTable <- calculateWhichPlayersToBuy(acquireTable)
  
  #filter on price
  acquireTable <- filter(acquireTable,ValueUnified >= pricemin) 
  acquireTable <- filter(acquireTable,ValueUnified <= pricemax)
  
  
  #Possible positions: SEE LOAD_FULL_DATA.R
  #acquireTable <- possiblePositions(acquireTable)
  #acquireTable$Positions <- paste(acquireTable$Preffered_Position,acquireTable$Club_Position,sep="/")
  
  #TO DO: Club_Position and Preffered_Position
  #if there is a position given, filter on position
  if(position != "Position"){
    acquireTable <- filter(acquireTable,Club_Position == position)
    
   # acquireTable <- filterOnPosition(acquireTable,position)
  #  acquireTable <- filter(acquireTable, position %in% ListPositions)
  }
  
    
  acquireTable <- acquireTable %>% select("Photo","Name","Nationality","Age","Club_Position","Rating","Potential","Value","Reason")
    
  return(acquireTable)  
}
