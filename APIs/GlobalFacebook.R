library(Rfacebook)
library(dplyr)
# token generated here: https://developers.facebook.com/tools/explorer 
#TOKEN QUINTEN
token <- "EAACEdEose0cBALIIxZA7u1RQiuZBZCFFKiZAGRbhHMAsHvB6ZCNpAEyLfeMruIVvb7AN2e2jK2TSHXNYyG4F7ThsZBRkZCAr3gj8v7jbshaMNzLqUiH2vWcwbPXatjkyKhFWDIhPkW0OFdIqUjzGLUTrNeFDPe9ZAZCV34IfkoA2nIZA4ACDeF5AjYeR2T5PyNBQQZD"
#TOKEN LEEN
token <-"EAACEdEose0cBABdw6GbbzYeuFRW4g7X0mHfjx8C7ACpxVLycSSLDAK5acKMJCObka6ZC2hpvxoq9m3aj4wWoZBhFMBsFmRERxZCfLYXZCXGt5ijgNIZCFvdgBNiZCn7Q62jzxUbcfiFEBvkCtdlaUdrWbqDXV8IhgsRy67RkPpDlQgnEEH7flIbVAXxGTN3fAww9b45zsytAZDZD"

#for(playername in fullData$Name[is.na(fullData$likes)]) {
#  try(page <- Rfacebook::searchPages(playername, token, n = 50))
#  page_summary <- page %>% summarize(total_likes = sum(likes), talking_about = sum(talking_about_count))
#  fullData$likes[fullData$Name == playername] <- page_summary$total_likes 
#  fullData$talking_about[fullData$Name == playername] <- page_summary$talking_about
#}

getPlayerFBLikes <- function(playername) {
  try(page <- Rfacebook::searchPages(playername, token, n = 50))
  page_summary <- page %>% summarize(total_likes = sum(likes), talking_about = sum(talking_about_count))
  return(page_summary)
}

#fullData$likes[565:10000] <- NA
#fullData$talking_about[565:10000] <- NA

#write.csv(fullData,"fullDataFBextended.csv")

