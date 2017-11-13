

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
  #old way
  returnTable <- filter(playerStats,name==playername)
  #new way
  returnTable <- filter(fullData,Name==playername) %>% select(Name,Nationality,Club_Position,Club,Rating,Preffered_Foot,Age)
 
  return (returnTable)
}
getPOTableClub <- function(clubname){
  #TODO: fix this
  #clubmembers <- filter(hometeams,team_long_name==clubname)
  
  #new way
  returnTable <- filter(fullData,Club==clubname)%>% select(Name,Nationality,Club_Position,Club,Rating,Preffered_Foot,Age)
  return (returnTable)  
}


#TODO: caching of sliders?
filterOnRating <- function(table,min,max){
  table <- filter(table,Rating <= max) %>% filter(Rating >= min) 
  #table <- table %>% select(Name,Nationality,Club_Position,Club,Preffered_Foot,Age,Rating)
  
  return (table) 
}
filterOnPace <- function(table,min,max){
  table <- table %>% mutate(Pace = as.integer((Acceleration + Speed)/2))
  
  table <- filter(table,Pace <= max) %>% filter(Pace >= min) 
  #table <- table %>% select(Name,Nationality,Club_Position,Club,Preffered_Foot,Age,Pace)
  
  return (table) 
}
filterOnShooting <- function(table,min,max){
  table <- table %>% mutate(Shooting = as.integer((Attacking_Position + Finishing +Shot_Power +Long_Shots + Volleys + Penalties)/6))
  
  table <- filter(table,Shooting <= max) %>% filter(Shooting >= min) 
  
  return (table) 
}

filterOnPassing <- function(table,min,max){
  table <- table %>% mutate(Passing = as.integer((Vision + Crossing + Freekick_Accuracy + Short_Pass + Long_Pass + Curve)/6))
  
  table <- filter(table,Passing <= max) %>% filter(Passing >= min) 
  
  return (table) 
}

filterOnDribbling <- function(table,min,max){
  table <- table %>% mutate(Dribblingx = as.integer((Agility + Balance + Reactions + Ball_Control + Dribbling + Composure)/6))
  
  table <- filter(table,Dribblingx <= max) %>% filter(Dribblingx >= min) 
  
  return (table) 
}
filterOnDefending <- function(table,min,max){
  table <- table %>% mutate(Defending = as.integer((Interceptions + Heading + Marking + Standing_Tackle + Sliding_Tackle)/5))
  
  table <- filter(table,Defending <= max) %>% filter(Defending >= min) 
  
  return (table) 
}

filterOnPhysicality <- function(table,min,max){
  table <- table %>% mutate(Physicality = as.integer((Jumping + Stamina + Strength + Aggression)/4))
  
  table <- filter(table,Physicality <= max) %>% filter(Physicality >= min) 
  
  return (table) 
}

filterOnPotential <- function(table,min,max){
  table <- table %>% mutate(Potential = as.integer((Rating/Age)*20))
  
  table <- filter(table,Potential <= max) %>% filter(Potential >= min) 
  
  return (table) 
}

getPOTableAttributes <- function(slidervalues){
  #rating
  ratingMin <- as.numeric(slidervalues$overallratingmin)
  ratingMax <- as.numeric(slidervalues$overallratingmax)
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
  #potential
  potentialmin <- as.numeric(slidervalues$potentialmin)
  potentialmax <- as.numeric(slidervalues$potentialmax)
  #price
  pricemin <- as.numeric(slidervalues$pricemin)
  pricemax <- as.numeric(slidervalues$pricemax)
  
  #rating
  #returnTable <- filter(fullData,Rating <= ratingMax) %>% filter(Rating >= ratingMin) 
  #FILTERS
  returnTable <- filterOnRating(fullData,ratingMin,ratingMax)
  returnTable <- filterOnPace(returnTable,pacemin,pacemax)
  returnTable <- filterOnShooting(returnTable,shootingmin,shootingmax)
  returnTable <- filterOnPassing(returnTable,passingmin,passingmax)
  #agility = dribbling
  returnTable <- filterOnDribbling(returnTable,agilitymin,agilitymax)
  returnTable <- filterOnDefending(returnTable,defendingmin,defendingmax)
  returnTable <- filterOnPhysicality(returnTable,physicalitymin,physicalitymax)
  returnTable <- filterOnPotential(returnTable,potentialmin,potentialmax)
  #TODO: price
  
  
  #select what to show
  #returnTable <- returnTable %>% select(Name,Nationality,Club_Position,Club,Rating,Preffered_Foot,Age)
  returnTable <- returnTable %>% select(Name,Nationality,Club_Position,Club,Rating,Preffered_Foot,Age,Pace,Shooting,Passing,Dribblingx,Physicality,Potential)
  
  return (returnTable)
}
