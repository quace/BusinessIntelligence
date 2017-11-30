#test 1
#playerImageTable <- data.frame(a=c("https://cdn.futbin.com/content/fifa18/img/players/192774.png?v=2","https://cdn.futbin.com/content/fifa18/img/players/203551.png?v=2","https://cdn.futbin.com/content/fifa18/img/players/200104.png?v=2"))
#playerImageTable$a <-sprintf("<img src='%s'>",playerImageTable$a)  
#x<-data.frame(a=c("<img src='https://cdn.futbin.com/content/fifa18/img/players/200104.png?v=2'>","vassri asdf asdfasdf","csdasdsriasfasf"))
#x$a<-gsub("sri",'<strong style="color:red">sri</strong>',x$a)

#test 2
#playerImageTable <- data.frame(picture=c(popularPlayers$picture))
#playerImageTable$picture <-sprintf("<img src='%s'>",playerImageTable$picture)  
#test 3
# htmlExtendedPopularPlayers <- popularPlayers
# htmlExtendedPopularPlayers$picture <- sprintf("<img src='%s'>",htmlExtendedPopularPlayers$picture)
# htmlExtendedPopularPlayers$country <- sprintf("<img src='%s'>",htmlExtendedPopularPlayers$country)
# htmlExtendedPopularPlayers$club <- sprintf("<img src='%s'>",htmlExtendedPopularPlayers$club)
source("APIs/GlobalFacebook.R")
currentStats <- c("","","")

getFacebookLikes <- function(playername){
  #clear current stats
  assign("currentStats",c("","",""),envir = .GlobalEnv)
  
  followers = ""
  if(playername != ""){
  FBstats <- getPlayerFBLikes(playername)
  followers <- toString(FBstats$total_likes)
  talking <- toString(FBstats$talking_about)
  #save in current stats
  assign("currentStats",c(playername,followers,talking),envir = .GlobalEnv)
  
  }
  
  
  return(followers)
}

getFacebookTalkingAbout <- function(playername){
  talkingabout = ""
  if(currentStats[1]==playername){
    talkingabout = currentStats[3]
  }
  return(talkingabout)

}
