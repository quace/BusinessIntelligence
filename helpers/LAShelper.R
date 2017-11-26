#Loan and Sell helper

#suggest which players to loan: low rating, high potential
calculateWhichPlayersToLoan <- function(table){
  #we need the potential
  table <- table %>% mutate(Potential = as.integer((Rating/Age)*20))
  
  #calculate the means
  meanPotential <- mean(table$Potential)
  meanRating <- mean(table$Rating)
  
  #if player has a rating below the mean and a potential above the mean -> loan
#  table$Loan[((table$Rating < meanRating) && (table$Potential > meanPotential))] <- as.character(icon('check-square'))
  table$Loan[(table$Rating < meanRating)] <- as.character(icon('check-square'))  
  table$Loan[(table$Potential <= meanPotential)] <- as.character(icon('square-o'))  
  
  return (table)
}

#suggest which players to sell
calculateWhichPlayersToSell <- function(table){
  return(table)
}


constructLoandSellTable <- function(club){
  #first filter to players of this club
  loanAndSellTable <- filter(fullData, Club == club)
  
  load.fontawesome()
  fa <- fontawesome(c('fa-check-square', 'fa-square-o'))
  
  
  
  loanAndSellTable$Loan <- as.character(icon('square-o')) #'<i class="fa fa-check-square" aria-hidden="true"></i>'
  loanAndSellTable <- calculateWhichPlayersToLoan(loanAndSellTable)
  
  loanAndSellTable$Sell <- as.character(icon('square-o'))
  loanAndSellTable <- calculateWhichPlayersToSell(loanAndSellTable)
  loanAndSellTable <- loanAndSellTable %>% select("Name","Nationality","Age","Rating","Potential","Loan","Sell")
  
  return(loanAndSellTable)
}
