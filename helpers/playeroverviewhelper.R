library(tidyr)
library(dplyr)
library(ggplot2)
library(ggthemes)

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
getPOTableAttributes <- function(slidervalues){
  ratingMin <- as.numeric(slidervalues$overallratingmin)
  ratingMax <- as.numeric(slidervalues$overallratingmax)
  
  
  returnTable <- filter(fullData,Rating <= ratingMax) %>% filter(Rating >= ratingMin) %>% select(Name,Nationality,Club_Position,Club,Rating,Preffered_Foot,Age)
  
  return (returnTable)
}
