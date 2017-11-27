#load data from the 'special csv files'
#fullData = read.csv("loaddata/FullData.csv",header=TRUE,encoding='UTF-8')
#fullData2 = read.csv("loaddata/CompleteDataset.csv",header=TRUE,encoding='UTF-8')
#playerIDdata = read.csv("loaddata/PlayerNames.csv",header=TRUE,encoding='UTF-8')


fullData = read.csv("loaddata/MergedCompleteDataNEW.csv",header=TRUE)
fullData$Photo <- sprintf("<img src='%s'>",fullData$Photo)
