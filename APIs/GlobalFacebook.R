library(Rfacebook)
library(dplyr)
# token generated here: https://developers.facebook.com/tools/explorer 
#TOKEN QUINTEN
token <- "EAACEdEose0cBALIIxZA7u1RQiuZBZCFFKiZAGRbhHMAsHvB6ZCNpAEyLfeMruIVvb7AN2e2jK2TSHXNYyG4F7ThsZBRkZCAr3gj8v7jbshaMNzLqUiH2vWcwbPXatjkyKhFWDIhPkW0OFdIqUjzGLUTrNeFDPe9ZAZCV34IfkoA2nIZA4ACDeF5AjYeR2T5PyNBQQZD"
#TOKEN LEEN
token <-"EAACEdEose0cBAPaZBNLMBpBE7msP7c2shyVFJIeJ1Wl1cpEI6uBQYnQ70M7DdUV9oQTX2BuRWvd4sKjE1oVYOOZCf2UbZAnkdWKdKJH1ptM1EENDWyZBhIisTr08MfqI8hBKKELnpAavnB9Vbv0tYxWxGSfuHbZBFmzwpdhmsyZCTLMfvYeuZCZBi1OA91NZCHbAZD"

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

