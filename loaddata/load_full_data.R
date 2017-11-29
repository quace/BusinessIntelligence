#load data from the 'special csv files'
#fullData = read.csv("loaddata/FullData.csv",header=TRUE,encoding='UTF-8')
#fullData2 = read.csv("loaddata/CompleteDataset.csv",header=TRUE,encoding='UTF-8')
#playerIDdata = read.csv("loaddata/PlayerNames.csv",header=TRUE,encoding='UTF-8')


# fullData = read.csv("loaddata/MergedCompleteDataNEW.csv",header=TRUE)
# fullData$Photo <- sprintf("<img src='%s'>",fullData$Photo)
# fullData$Flag <- sprintf("<img src='%s'>",fullData$Flag)
# fullData$Club.Logo <- sprintf("<img src='%s'>",fullData$Club.Logo)
# 
# fullData <- fullData%>% mutate(Positions = ifelse(Club_Position %in% strsplit(toString(Preffered_Position),"/"),Preffered_Position , paste(Preffered_Position,Club_Position,sep="/")))
#fullData <- fullData %>% rowwise() %>% mutate(Positions = ifelse(Club_Position %in% unlist(strsplit(toString(Preffered_Position),"/")),Preffered_Position , paste(Preffered_Position,Club_Position,sep="/")))

# fullData$test <- fullData$Club_Position %in% unlist(strsplit(toString(fullData$Preffered_Position),"[/]"))
# fullData$Positions <- paste(fullData$Preffered_Position,fullData$Club_Position,sep="/")
# fullData <- fullData %>% mutate(Positions = ifelse(test,Preffered_Position,Positions))

#fullData$Positions[fullData$test] <- fullData$Club_Position[fullData$test]

#fullData <- fullData%>% mutate(Positions = ifelse(test,Preffered_Position , paste(Preffered_Position,Club_Position,sep="/")))

fullData = read.csv("loaddata/fullDataNEW.csv",header=TRUE)