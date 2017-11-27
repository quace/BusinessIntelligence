#GLOBAL VARIABLES

dontShowColumns = c("")



#METHOD 1: works but super duper slow
#TODO: fix!
#construct a new data frame with only a part of the info
newPlayerStats <- data.frame("name" = player_attributes$player_fifa_api_id,
                             "overal rating" = player_attributes$overall_rating,
                             "potential" = player_attributes$potential,
                             "preferred foot" = player_attributes$preferred_foot)

#replace the player id -> name
row.index = function(d) which (newPlayerStats$name == d)[1]
indices = sapply (player$player_fifa_api_id, row.index)
newPlayerStats$name[indices] = player$player_name

#drop all rows that didnt match with a name
playerStats = newPlayerStats[indices,]



#METHOD 2: WERKT VAN GEEN KANTEN EN I DUNNO WHY
#simplefiedPlayer  <- data.frame( "player_fifa_api_id" = player$player_fifa_api_id,"name" = player$player_name)
#mergedPlayers <- merge(simplefiedPlayer, player_attributes, by ="player_fifa_api_id")
#newPlayerStats <- mergedPlayers

#newPlayerStats <- data.frame("name" = mergedPlayers$player_name,
 #                            "overal rating" = mergedPlayers$overall_rating,
  #                           "potential" = mergedPlayers$potential,
   #                          "preferred foot" = mergedPlayers$preferred_foot)




hometeams <- matches  %>% select(id, date, home_team_api_id, home_team_goal,home_player_1:home_player_11) %>% gather(position, playerid,  home_player_1:home_player_11) %>% merge(team,all=TRUE) %>% merge(player,all=TRUE)
awayteams <- matches %>% select(id, date, away_team_api_id, away_team_goal,away_player_1:away_player_11) %>% gather(position, playerid,  away_player_1:away_player_11) %>% merge(team,all=TRUE) %>% merge(player,all=TRUE)
matches  %>% select(id, date, home_team_api_id, season, home_team_goal, home_player_1:home_player_11) %>% gather(position, playerid,  home_player_1:home_player_11) %>% merge(team, all= T) %>% merge(player, all = T) %>% filter(playerid == 2625) %>% group_by(id) %>% ggplot(aes(x= season, y= home_team_goal)) + geom_boxplot()   +theme(axis.text.x = element_text(angle = 90, hjust = 1))



#theme_hc(bgcolor = "darkunica") +
 # scale_fill_hc("darkunica")"



#########################
#SEARCH FUNCTION#
#########################
getPOTablePlayerName <- function(playername){
  if(playername == "All Players"){
    returnTable <- fullData %>% select(Name,Nationality,Club_Position,Club,Rating,Preffered_Foot,Age)
  }else{
  #new way
  returnTable <- filter(fullData,Name==playername) %>% select(Name,Nationality,Club_Position,Club,Rating,Preffered_Foot,Age)
  }
  return (returnTable)
}
getPOTableClub <- function(clubname){
  #TODO: fix this
  #clubmembers <- filter(hometeams,team_long_name==clubname)
  
  #new way
  returnTable <- filter(fullData,Club==clubname)%>% select(Name,Nationality,Club_Position,Club,Rating,Preffered_Foot,Age)
  return (returnTable)  
}


##############Advanced Search##########################
filterToMatchExact <- function(table,columnname,matchcriteria){
  table <- filter(table,columnname == matchcriteria) 
  return(table)
}

#filterBetweenMinMax <- function(table,columnname,min,max){
#  table <- filter(table,columnname <= max) %>% filter(columnname >= min) 
#  return(table)
#}

filterLargeThanMin <- function(table,columnname,min){
  table <- filter(table,columnname >= min) 
  return(table)
}
filterSmallerThanMax <- function(table,columnname,max){
  table <- filter(table,columnname <= max)
  return(table) 
}


################################################




filterOnRating <- function(table,min,max){
 # table <- filterBetweenMinMax(table,table$Rating,min,max)
  table <- filterSmallerThanMax(table,table$Rating,max)
  table <- filterLargeThanMin(table,table$Rating,min)
  
  return (table) 
}

filterOnPace <- function(table,min,max){
  #table <- table %>% mutate(Pace = as.integer(0.45*Acceleration + 0.55*Speed))
  
  #table <- filterBetweenMinMax(table,table$Pace, min, max)
  table <- filterSmallerThanMax(table,table$Pace,max)
  table <- filterLargeThanMin(table,table$Pace,min)
  
  return (table) 
}

filterOnShooting <- function(table,min,max){
  #table <- table %>% mutate(Shooting = as.integer(0.05*Attacking_Position + 0.45*Finishing +0.20*Shot_Power +0.20*Long_Shots + 0.05*Volleys + 0.05*Penalties))
  
#  table <- filterBetweenMinMax(table,table$Shooting,min,max)
  table <- filterSmallerThanMax(table,table$Shooting,max)
  table <- filterLargeThanMin(table,table$Shooting,min)
  
  
  return (table) 
}

filterOnPassing <- function(table,min,max){
  #table <- table %>% mutate(Passing = as.integer(0.2*Vision + 0.2*Crossing + 0.05*Freekick_Accuracy + 0.35*Short_Pass + 0.15*Long_Pass + 0.05*Curve))
  
#  table <- filterBetweenMinMax(table,table$Passing,min,max)
  table <- filterSmallerThanMax(table,table$Passing,max)
  table <- filterLargeThanMin(table,table$Passing,min)
  
  return (table) 
}

filterOnDribbling <- function(table,min,max){
  #table <- table %>% mutate(Dribblingx = as.integer(0.1*Agility + 0.05*Balance + 0.05*Reactions + 0.3*Ball_Control + 0.5*Dribbling))
  
#  table <- filterBetweenMinMax(table,table$Dribblingx,min,max)
  table <- filterSmallerThanMax(table,table$Dribblingx,max)
  table <- filterLargeThanMin(table,table$Dribblingx,min)
  
  return (table) 
}
filterOnDefending <- function(table,min,max){
  #table <- table %>% mutate(Defending = as.integer(0.2*Interceptions + 0.1*Heading + 0.3*Marking + 0.3*Standing_Tackle + 0.1*Sliding_Tackle))
  
#  table <- filterBetweenMinMax(table,table$Defending,min,max)
  table <- filterSmallerThanMax(table,table$Defending,max)
  table <- filterLargeThanMin(table,table$Defending,min)
  
  return (table) 
}

filterOnPhysicality <- function(table,min,max){
  #table <- table %>% mutate(Physicality = as.integer(0.05*Jumping + 0.25*Stamina + 0.5*Strength + 0.2*Aggression))
  
#  table <- filterBetweenMinMax(table,table$Physicality,min,max)
  table <- filterSmallerThanMax(table,table$Physicality,max)
  table <- filterLargeThanMin(table,table$Physicality,min)
  
  return (table) 
}

filterOnPotential <- function(table,min,max){
  #table <- table %>% mutate(Potential = as.integer((Rating/Age)*20))
  
#  table <- filterBetweenMinMax(table,table$Potential,min,max)
  table <- filterSmallerThanMax(table,table$Potential,max)
  table <- filterLargeThanMin(table,table$Potential,min)
  
  return (table) 
}

#TO DO ######
goalKeeperScore <- function(){
  table <- table %>% mutate(GK_Score = as.integer((GK_Positioning + GK_Diving + GK_Kicking + GK_Handling + GK_Reflexes )/5))
  
}
###########


filterOnAge <- function(table,min,max){
  
#  table <- filterBetweenMinMax(table,table$Age,min,max)
  table <- filterSmallerThanMax(table,table$Age,max)
  table <- filterLargeThanMin(table,table$Age,min)
  
  return (table) 
}
#min and max are price in k, so multiply *1000
filterOnPrice <- function(table,min,max){
  min = min*1000
  max = max*1000
  
  table <- filterSmallerThanMax(table,table$ValueUnified,max)
  table <- filterLargeThanMin(table,table$ValueUnified,min)
  
  return (table) 
}

filterOnSimplifiedAttributes <- function(returnTable,slidervalues){
 #pace
  pacemin <- as.numeric(slidervalues$pacemin)
  pacemax <- as.numeric(slidervalues$pacemax)
  #shooting
  shootingmin <- as.numeric(slidervalues$shootingmin)
  shootingmax <- as.numeric(slidervalues$shootingmax)
  #passing
  passingmin <- as.numeric(slidervalues$passingmin)
  passingmax <- as.numeric(slidervalues$passingmax)
  #agility
  agilitymin <- as.numeric(slidervalues$agilitymin)
  agilitymax <- as.numeric(slidervalues$agilitymax)
  #defending
  defendingmin <- as.numeric(slidervalues$defendingmin)
  defendingmax <- as.numeric(slidervalues$defendingmax)
  #physicality 
  physicalitymin <- as.numeric(slidervalues$physicalitymin)
  physicalitymax <- as.numeric(slidervalues$physicalitymax)
  
  
  
  returnTable <- filterOnPace(returnTable,pacemin,pacemax)
  returnTable <- filterOnShooting(returnTable,shootingmin,shootingmax)
  returnTable <- filterOnPassing(returnTable,passingmin,passingmax)
  #agility = dribbling
  returnTable <- filterOnDribbling(returnTable,agilitymin,agilitymax)
  returnTable <- filterOnDefending(returnTable,defendingmin,defendingmax)
  returnTable <- filterOnPhysicality(returnTable,physicalitymin,physicalitymax)
  
  return (returnTable)
  
}

#none of these attributes are composed, all are singular so we can directly use the filter function
filterOnExtendedAttributes <- function(returnTable,slidervalues){
  #acceleration
  accelerationmax = as.numeric(slidervalues$accelerationmax)
  accelerationmin = as.numeric(slidervalues$accelerationmin)
  if((accelerationmin != 0) || (accelerationmax != 100)){
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Acceleration,accelerationmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Acceleration,accelerationmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Acceleration")
    assign("dontShowColumns",help,envir = .GlobalEnv)
  }
  
  #speed 
  speedmax = as.numeric(slidervalues$speedmax)
  speedmin = as.numeric(slidervalues$speedmin)
  if((speedmin != 0) || (speedmax != 100)){
  
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Speed,speedmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Speed,speedmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Speed")
    assign("dontShowColumns",help,envir = .GlobalEnv)
  }
  
  #attacking pos
  attackingposmax = as.numeric(slidervalues$attackingposmax)
  attackingposmin = as.numeric(slidervalues$attackingposmin)
  if((attackingposmin != 0) || (attackingposmax != 100)){
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Attacking_Position,attackingposmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Attacking_Position,attackingposmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Attacking_Position")
    assign("dontShowColumns",help,envir = .GlobalEnv)
  }
  
  #finishing
  finishingmax = as.numeric(slidervalues$finishingmax)
  finishingmin = as.numeric(slidervalues$finishingmin)
  if((finishingmin != 0) || (finishingmax != 100)){
    
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Finishing,finishingmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Finishing,finishingmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Finishing")
    assign("dontShowColumns",help,envir = .GlobalEnv)
  }
  
  #shot power
  shotpowermax = as.numeric(slidervalues$shotpowermax)
  shotpowermin = as.numeric(slidervalues$shotpowermin)
  if((shotpowermin != 0) || (shotpowermax != 100)){
    
   returnTable <- filterSmallerThanMax(returnTable,returnTable$Shot_Power,shotpowermax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Shot_Power,shotpowermin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Shot_Power")
    assign("dontShowColumns",help,envir = .GlobalEnv)
  }
  
  
  #long shots
  longshotsmax = as.numeric(slidervalues$longshotsmax)
  longshotsmin = as.numeric(slidervalues$longshotsmin)
  if((longshotsmin != 0) || (longshotsmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Long_Shots,longshotsmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Long_Shots,longshotsmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Long_Shots")
    assign("dontShowColumns",help,envir = .GlobalEnv)
  }
  
  #volleys
  volleysmax = as.numeric(slidervalues$volleysmax)
  volleysmin = as.numeric(slidervalues$volleysmin)
  if((volleysmin != 0) || (volleysmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Volleys,volleysmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Volleys,volleysmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Volleys")
    assign("dontShowColumns",help,envir = .GlobalEnv) 
  }
  
  #penalties
  penaltiesmax = as.numeric(slidervalues$penaltiesmax)
  penaltiesmin = as.numeric(slidervalues$penaltiesmin)
  if((penaltiesmin != 0) || (penaltiesmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Penalties,penaltiesmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Penalties,penaltiesmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Penalties")
    assign("dontShowColumns",help,envir = .GlobalEnv) 
  }
  
  #vision
  visionmax = as.numeric(slidervalues$visionmax)
  visionmin = as.numeric(slidervalues$visionmin)
  if((visionmin != 0) || (visionmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Vision,visionmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Vision,visionmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Vision")
    assign("dontShowColumns",help,envir = .GlobalEnv) 
  }
  
  #crossing
  crossingmax = as.numeric(slidervalues$crossingmax)
  crossingmin = as.numeric(slidervalues$crossingmin)
  if((crossingmin != 0) || (crossingmax != 100)){
    
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Crossing,crossingmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Crossing,crossingmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Crossing")
    assign("dontShowColumns",help,envir = .GlobalEnv) 
  }
  
  #freekick accuracy
  fkaccuracymax = as.numeric(slidervalues$fkaccuracymax)
  fkaccuracymin = as.numeric(slidervalues$fkaccuracymin)
  if((fkaccuracymin != 0) || (fkaccuracymax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Freekick_Accuracy,fkaccuracymax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Freekick_Accuracy,fkaccuracymin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Freekick_Accuracy")
    assign("dontShowColumns",help,envir = .GlobalEnv) 
  }
  
  #short pass
  shortpassmax = as.numeric(slidervalues$shortpassmax)
  shortpassmin = as.numeric(slidervalues$shortpassmin)
  if((shortpassmin != 0) || (shortpassmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Short_Pass,shortpassmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Short_Pass,shortpassmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Short_Pass")
    assign("dontShowColumns",help,envir = .GlobalEnv)  
  }
  
  #long pass
  longpassmax = as.numeric(slidervalues$longpassmax)
  longpassmin = as.numeric(slidervalues$longpassmin)
  if((longpassmin != 0) || (longpassmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Long_Pass,longpassmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Long_Pass,longpassmin)
  }else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Long_Pass")
    assign("dontShowColumns",help,envir = .GlobalEnv)  
  }
  
  #curve
  curvemax = as.numeric(slidervalues$curvemax)
  curvemin = as.numeric(slidervalues$curvemin)
  if((curvemin != 0) || (curvemax != 100)){
    
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Curve,curvemax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Curve,curvemin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Curve")
    assign("dontShowColumns",help,envir = .GlobalEnv)  
  }
  
  #agility
  agilitymax = as.numeric(slidervalues$agilitymax)
  agilitymin = as.numeric(slidervalues$agilitymin)
  if((agilitymin != 0) || (agilitymax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Agility,agilitymax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Agility,agilitymin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Agility")
    assign("dontShowColumns",help,envir = .GlobalEnv) 
  }
  
  #balance
  balancemax = as.numeric(slidervalues$balancemax)
  balancemin = as.numeric(slidervalues$balancemin)
  if((balancemin != 0) || (balancemax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Balance,balancemax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Balance,balancemin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Balance")
    assign("dontShowColumns",help,envir = .GlobalEnv) 
  }
  
  #reactions
  reactionsmax = as.numeric(slidervalues$reactionsmax)
  reactionsmin = as.numeric(slidervalues$reactionsmin)
  
  if((reactionsmin != 0) || (reactionsmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Reactions,reactionsmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Reactions,reactionsmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Reactions")
    assign("dontShowColumns",help,envir = .GlobalEnv)
  }
  
  #ballcontrol
  ballcontrolmax = as.numeric(slidervalues$ballcontrolmax)
  ballcontrolmin = as.numeric(slidervalues$ballcontrolmin)
  
  if((ballcontrolmin != 0) || (ballcontrolmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Ball_Control,ballcontrolmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Ball_Control,ballcontrolmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Ball_Control")
    assign("dontShowColumns",help,envir = .GlobalEnv)
  }
  
  #dribbling
  dribblingmax = as.numeric(slidervalues$dribblingmax)
  dribblingmin = as.numeric(slidervalues$dribblingmin)
  if((dribblingmin != 0) || (dribblingmax != 100)){
    
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Dribbling,dribblingmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Dribbling,dribblingmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Dribbling")
    assign("dontShowColumns",help,envir = .GlobalEnv)
  }
  
  #composure
  composuremax = as.numeric(slidervalues$composuremax)
  composuremin = as.numeric(slidervalues$composuremin)
  
  if((composuremin != 0) || (composuremax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Composure,composuremax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Composure,composuremin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Composure")
    assign("dontShowColumns",help,envir = .GlobalEnv) 
  }
  
  #interceptions
  interceptionsmax = as.numeric(slidervalues$interceptionsmax)
  interceptionsmin = as.numeric(slidervalues$interceptionsmin)
  if((interceptionsmin != 0) || (interceptionsmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Interceptions,interceptionsmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Interceptions,interceptionsmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Interceptions")
    assign("dontShowColumns",help,envir = .GlobalEnv) 
  }
  
  #heading
  headingmax = as.numeric(slidervalues$headingmax)
  headingmin = as.numeric(slidervalues$headingmin)
  if((headingmin != 0) || (headingmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Heading,headingmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Heading,headingmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Heading")
    assign("dontShowColumns",help,envir = .GlobalEnv)  
  }
  
  #marking
  markingmax = as.numeric(slidervalues$markingmax)
  markingmin = as.numeric(slidervalues$markingmin)
  if((markingmin != 0) || (markingmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Marking,markingmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Marking,markingmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Marking")
    assign("dontShowColumns",help,envir = .GlobalEnv)  
    
  }
  
  #standing tackle
  standingtacklemax = as.numeric(slidervalues$standingtacklemax)
  standingtacklemin = as.numeric(slidervalues$standingtacklemin)
  if((standingtacklemin != 0) || (standingtacklemax != 100)){
   returnTable <- filterSmallerThanMax(returnTable,returnTable$Standing_Tackle,standingtacklemax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Standing_Tackle,standingtacklemin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Standing_Tackle")
    assign("dontShowColumns",help,envir = .GlobalEnv)  
  }
  
  #sliding tackle
  slidingtacklemax = as.numeric(slidervalues$slidingtacklemax)
  slidingtacklemin = as.numeric(slidervalues$slidingtacklemin)
  
  if((slidingtacklemin != 0) || (slidingtacklemax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Sliding_Tackle,slidingtacklemax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Sliding_Tackle,slidingtacklemin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Sliding_Tackle")
    assign("dontShowColumns",help,envir = .GlobalEnv)  
  }
  
  #jumping
  jumpingmax = as.numeric(slidervalues$jumpingmax)
  jumpingmin = as.numeric(slidervalues$jumpingmin)
  if((jumpingmin != 0) || (jumpingmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Jumping,jumpingmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Jumping,jumpingmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Jumping")
    assign("dontShowColumns",help,envir = .GlobalEnv)  
    
  }
  
  #stamina
  staminamax = as.numeric(slidervalues$staminamax)
  staminamin = as.numeric(slidervalues$staminamin)
  if((staminamin != 0) || (staminamax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Stamina,staminamax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Stamina,staminamin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Stamina")
    assign("dontShowColumns",help,envir = .GlobalEnv)  
    
  }
  
  #strength
  strengthmax = as.numeric(slidervalues$strengthmax)
  strengthmin = as.numeric(slidervalues$strengthmin)
  if((strengthmin != 0) || (strengthmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Strength,staminamax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Strength,staminamin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Strength")
    assign("dontShowColumns",help,envir = .GlobalEnv)  
    
  }
  
  #aggression
  aggressionmax = as.numeric(slidervalues$aggressionmax)
  aggressionmin = as.numeric(slidervalues$aggressionmin)
  
  if((aggressionmin != 0) || (aggressionmax != 100)){
    returnTable <- filterSmallerThanMax(returnTable,returnTable$Aggression,aggressionmax)
  returnTable <- filterLargeThanMin(returnTable,returnTable$Aggression,aggressionmin)
  } else {
    #dont show this column in the end table
    help <- append(dontShowColumns,"Aggression")
    assign("dontShowColumns",help,envir = .GlobalEnv)  
  }
  return (returnTable)
}


getPOTableAdvanced <- function(simplified, slidervalues,country,position,preferredfoot){
  #data to use
  returnTable <- fullData
  #reset vector of columns to show
  assign("dontShowColumns",c(""),envir = .GlobalEnv)
  
  
  if(simplified){
    returnTable <- filterOnSimplifiedAttributes(returnTable, slidervalues)
  } else {
    returnTable <- filterOnExtendedAttributes(returnTable, slidervalues)
  }
  #rating
  ratingMin <- as.numeric(slidervalues$overallratingmin)
  ratingMax <- as.numeric(slidervalues$overallratingmax)
  
  #potential
  potentialmin <- as.numeric(slidervalues$potentialmin)
  potentialmax <- as.numeric(slidervalues$potentialmax)
  #price
  pricemin <- as.numeric(slidervalues$pricemin)
  pricemax <- as.numeric(slidervalues$pricemax)
  #age
  agemin <- as.numeric(slidervalues$agemin)
  agemax <- as.numeric(slidervalues$agemax)
  
  
 #GENERAL FILTERS
  returnTable <- filterOnRating(returnTable,ratingMin,ratingMax)
  returnTable <- filterOnPotential(returnTable,potentialmin,potentialmax)
  returnTable <- filterOnPrice(returnTable,pricemin,pricemax)
  returnTable <- filterOnAge(returnTable,agemin,agemax)
  
  
  #country
  if(!country == "Country"){
  returnTable <- filterToMatchExact(returnTable,returnTable$Nationality,country)
  }
  #position
  if(!position == "Position"){
    returnTable <- filterToMatchExact(returnTable,returnTable$Club_Position,position)
  }
  #preferred foot
  if(!preferredfoot == "Preferred Foot"){
    returnTable <- filterToMatchExact(returnTable,returnTable$Preffered_Foot,preferredfoot)
  }
  
  #TO DO: select the right things to show depending if simplified or not
  if(simplified){
  returnTable <- returnTable %>% select(Name,Nationality,Club_Position,Club,Preffered_Foot,Age,Potential,Rating,Value,Pace,Shooting,Passing,Dribblingx,Physicality)
  } else {
    returnTable <- returnTable %>% select(Name,Nationality,Club_Position,Club,Preffered_Foot,Age,Potential,Rating,Value,Acceleration,Speed,Attacking_Position,Finishing,Shot_Power,Long_Shots,Volleys,Penalties,Vision,Crossing,Freekick_Accuracy,Short_Pass,Long_Pass,Curve,Agility,Balance,Reactions,Ball_Control,Dribbling,Composure,Interceptions,Heading,Marking,Standing_Tackle,Sliding_Tackle,Jumping,Stamina,Strength,Aggression)
    #remove the first ""
    dontShowColumns <- dontShowColumns[-1]
    #dont show these columns in the resulting table
    returnTable <- returnTable[,!(colnames(returnTable) %in% dontShowColumns)]
  }
  
  
  return (returnTable)
}
