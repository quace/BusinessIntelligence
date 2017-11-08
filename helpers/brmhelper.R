#test 1
#playerImageTable <- data.frame(a=c("https://cdn.futbin.com/content/fifa18/img/players/192774.png?v=2","https://cdn.futbin.com/content/fifa18/img/players/203551.png?v=2","https://cdn.futbin.com/content/fifa18/img/players/200104.png?v=2"))
#playerImageTable$a <-sprintf("<img src='%s'>",playerImageTable$a)  
#x<-data.frame(a=c("<img src='https://cdn.futbin.com/content/fifa18/img/players/200104.png?v=2'>","vassri asdf asdfasdf","csdasdsriasfasf"))
#x$a<-gsub("sri",'<strong style="color:red">sri</strong>',x$a)

#test 2
#playerImageTable <- data.frame(picture=c(popularPlayers$picture))
#playerImageTable$picture <-sprintf("<img src='%s'>",playerImageTable$picture)  
#test 3
htmlExtendedPopularPlayers <- popularPlayers
htmlExtendedPopularPlayers$picture <- sprintf("<img src='%s'>",htmlExtendedPopularPlayers$picture)
htmlExtendedPopularPlayers$country <- sprintf("<img src='%s'>",htmlExtendedPopularPlayers$country)
htmlExtendedPopularPlayers$club <- sprintf("<img src='%s'>",htmlExtendedPopularPlayers$club)