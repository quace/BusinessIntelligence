

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
  table <- table %>% mutate(Pace = as.integer((Acceleration + Speed)/2))
  
  #table <- filterBetweenMinMax(table,table$Pace, min, max)
  table <- filterSmallerThanMax(table,table$Pace,max)
  table <- filterLargeThanMin(table,table$Pace,min)
  
  return (table) 
}

filterOnShooting <- function(table,min,max){
  table <- table %>% mutate(Shooting = as.integer((Attacking_Position + Finishing +Shot_Power +Long_Shots + Volleys + Penalties)/6))
  
#  table <- filterBetweenMinMax(table,table$Shooting,min,max)
  table <- filterSmallerThanMax(table,table$Shooting,max)
  table <- filterLargeThanMin(table,table$Shooting,min)
  
  
  return (table) 
}

filterOnPassing <- function(table,min,max){
  table <- table %>% mutate(Passing = as.integer((Vision + Crossing + Freekick_Accuracy + Short_Pass + Long_Pass + Curve)/6))
  
#  table <- filterBetweenMinMax(table,table$Passing,min,max)
  table <- filterSmallerThanMax(table,table$Passing,max)
  table <- filterLargeThanMin(table,table$Passing,min)
  
  return (table) 
}

filterOnDribbling <- function(table,min,max){
  table <- table %>% mutate(Dribblingx = as.integer((Agility + Balance + Reactions + Ball_Control + Dribbling + Composure)/6))
  
#  table <- filterBetweenMinMax(table,table$Dribblingx,min,max)
  table <- filterSmallerThanMax(table,table$Dribblingx,max)
  table <- filterLargeThanMin(table,table$Dribblingx,min)
  
  return (table) 
}
filterOnDefending <- function(table,min,max){
  table <- table %>% mutate(Defending = as.integer((Interceptions + Heading + Marking + Standing_Tackle + Sliding_Tackle)/5))
  
#  table <- filterBetweenMinMax(table,table$Defending,min,max)
  table <- filterSmallerThanMax(table,table$Defending,max)
  table <- filterLargeThanMin(table,table$Defending,min)
  
  return (table) 
}

filterOnPhysicality <- function(table,min,max){
  table <- table %>% mutate(Physicality = as.integer((Jumping + Stamina + Strength + Aggression)/4))
  
#  table <- filterBetweenMinMax(table,table$Physicality,min,max)
  table <- filterSmallerThanMax(table,table$Physicality,max)
  table <- filterLargeThanMin(table,table$Physicality,min)
  
  return (table) 
}

filterOnPotential <- function(table,min,max){
  table <- table %>% mutate(Potential = as.integer((Rating/Age)*20))
  
#  table <- filterBetweenMinMax(table,table$Potential,min,max)
  table <- filterSmallerThanMax(table,table$Potential,max)
  table <- filterLargeThanMin(table,table$Potential,min)
  
  return (table) 
}

filterOnAge <- function(table,min,max){
  
#  table <- filterBetweenMinMax(table,table$Age,min,max)
  table <- filterSmallerThanMax(table,table$Age,max)
  table <- filterLargeThanMin(table,table$Age,min)
  
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
 # returnTable <- filterBetweenMinMax(returnTable,returnTable$Acceleration,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Acceleration,as.numeric(slidervalues$accelerationmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Acceleration,as.numeric(slidervalues$accelerationmin))
  
  #speed 
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Speed,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Speed,as.numeric(slidervalues$speedmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Speed,as.numeric(slidervalues$speedmin))
  
  #attacking pos
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Attacking_Position,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Attacking_Position,as.numeric(slidervalues$attackingposmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Attacking_Position,as.numeric(slidervalues$attackingposmin))
  
  #finishing
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Finishing,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Finishing,as.numeric(slidervalues$finishingmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Finishing,as.numeric(slidervalues$finishingmin))
  
  #shot power
 # returnTable <- filterBetweenMinMax(returnTable,returnTable$Shot_Power,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Shot_Power,as.numeric(slidervalues$shotpowermax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Shot_Power,as.numeric(slidervalues$shotpowermin))
  
  #long shots
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Long_Shots,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Long_Shots,as.numeric(slidervalues$longshotsmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Long_Shots,as.numeric(slidervalues$longshotsmin))
  
  #volleys
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Volleys,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Volleys,as.numeric(slidervalues$volleysmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Volleys,as.numeric(slidervalues$volleysmin))
  
  #penalties
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Penalties,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Penalties,as.numeric(slidervalues$penaltiesmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Penalties,as.numeric(slidervalues$penaltiesmin))
  
  #vision
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Vision,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Vision,as.numeric(slidervalues$visionmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Vision,as.numeric(slidervalues$visionmin))
  
  #crossing
 # returnTable <- filterBetweenMinMax(returnTable,returnTable$Crossing,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Crossing,as.numeric(slidervalues$crossingmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Crossing,as.numeric(slidervalues$crossingmin))
  
  #freekick accuracy
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Freekick_Accuracy,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Freekick_Accuracy,as.numeric(slidervalues$fkaccuracymax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Freekick_Accuracy,as.numeric(slidervalues$fkaccuracymin))
  
  #short pass
 # returnTable <- filterBetweenMinMax(returnTable,returnTable$Short_Pass,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Short_Pass,as.numeric(slidervalues$shortpassmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Short_Pass,as.numeric(slidervalues$shortpassmin))
  
  #long pass
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Long_Pass,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Long_Pass,as.numeric(slidervalues$longpassmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Long_Pass,as.numeric(slidervalues$longpassmin))
  
  #curve
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Curve,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Curve,as.numeric(slidervalues$curvemax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Curve,as.numeric(slidervalues$curvemin))
  
  #agility
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Agility,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Agility,as.numeric(slidervalues$agilitymax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Agility,as.numeric(slidervalues$agilitymin))
  
  #balance
 # returnTable <- filterBetweenMinMax(returnTable,returnTable$Balance,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Balance,as.numeric(slidervalues$balancemax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Balance,as.numeric(slidervalues$balancemin))
  
  #reactions
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Reactions,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Reactions,as.numeric(slidervalues$reactionsmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Reactions,as.numeric(slidervalues$reactionsmin))
  
  #ballcontrol
 # returnTable <- filterBetweenMinMax(returnTable,returnTable$Ball_Control,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Ball_Control,as.numeric(slidervalues$ballcontrolmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Ball_Control,as.numeric(slidervalues$ballcontrolmin))
  
  #dribbling
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Dribbling,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Dribbling,as.numeric(slidervalues$dribblingmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Dribbling,as.numeric(slidervalues$dribblingmin))
  
  #composure
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Composure,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Composure,as.numeric(slidervalues$composuremax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Composure,as.numeric(slidervalues$composuremin))
  
  #interceptions
 # returnTable <- filterBetweenMinMax(returnTable,returnTable$Interceptions,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Interceptions,as.numeric(slidervalues$interceptionsmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Interceptions,as.numeric(slidervalues$interceptionsmin))
  
  #heading
 # returnTable <- filterBetweenMinMax(returnTable,returnTable$Heading,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Heading,as.numeric(slidervalues$headingmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Heading,as.numeric(slidervalues$headingmin))
  
  #marking
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Marking,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Marking,as.numeric(slidervalues$markingmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Marking,as.numeric(slidervalues$markingmin))
  
  #standing tackle
 # returnTable <- filterBetweenMinMax(returnTable,returnTable$Standing_Tackle,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Standing_Tackle,as.numeric(slidervalues$standingtacklemax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Standing_Tackle,as.numeric(slidervalues$standingtacklemin))
  
  #sliding tackle
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Sliding_Tackle,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Sliding_Tackle,as.numeric(slidervalues$slidingtacklemax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Sliding_Tackle,as.numeric(slidervalues$slidingtacklemin))
  
  #jumping
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Jumping,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Jumping,as.numeric(slidervalues$jumpingmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Jumping,as.numeric(slidervalues$jumpingmin))
  
  #stamina
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Stamina,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Stamina,as.numeric(slidervalues$staminamax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Stamina,as.numeric(slidervalues$staminamin))
  
  #strength
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Strength,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Strength,as.numeric(slidervalues$strengthmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Strength,as.numeric(slidervalues$strengthmin))
  
  #aggression
#  returnTable <- filterBetweenMinMax(returnTable,returnTable$Aggression,,)
  returnTable <- filterSmallerThanMax(returnTable,returnTable$Aggression,as.numeric(slidervalues$aggressionmax))
  returnTable <- filterLargeThanMin(returnTable,returnTable$Aggression,as.numeric(slidervalues$aggressionmin))
  
  return (returnTable)
}



getPOTableAdvanced <- function(simplified, slidervalues,country,position,preferredfoot){
  #data to use
  returnTable <- fullData
  
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
  #TODO: price
  
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
  returnTable <- returnTable %>% select(Name,Nationality,Club_Position,Club,Rating,Preffered_Foot,Age,Pace,Shooting,Passing,Dribblingx,Physicality,Potential)
  } else {
    returnTable <- returnTable %>% select(Name,Nationality,Club_Position,Club,Rating,Preffered_Foot,Age)
    
  }
  
  return (returnTable)
}
