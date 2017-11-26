#transform(fullData2,Name = sub("^\\S+\\s","",Name))
#fullData2 <- rename(fullData2, c("Name"="Name2"))
#testfullData <- transform(fullData,Name2 = (paste(substring(Name,1,1),". ",sub("^\\S+\\s","",Name),sep="")))
#mergedData <- merge(x = testfullData, y = fullData2[,c("Name2","Photo","Flag","Club.Logo","Value","Wage")], by = "Name2")
#write.csv(mergedData,file="MergedData5.csv")


#mergedData <- merge(x = fullData3[,!colnames(fullData3) %in% c("Photo","Flag","Club.Logo","Value","Wage")], y = fullData2[,c("Name","Photo","Flag","Club.Logo","Value","Wage")], by = "Name")
#write.csv(unique(mergedData),file="MergedData13.csv")

#add ID to player names
IDextendedData <- transform(playerIDdata, ID = sub("/player/(.+?)/.*", "\\1", playerIDdata$url))
#write.csv(IDextendedData,file="IDextendedData.csv")

#add this ID to the fullData frame matching on player name
#IDextendedFullData <- merge(x = fullData, y = IDextendedData[,c("Name","ID")],by="Name")
IDextendedFullData <- cbind(fullData, IDextendedData[,c("ID","url")])
#write.csv(IDextendedFullData,file="IDextendedFullData.csv")

#merge this with the completeDataset
MergedCompleteData <- merge(x = IDextendedFullData, y = fullData2[,c("ID","Photo","Flag","Club.Logo","Value","Wage")],by="ID")
#write.csv(MergedCompleteData,file="MergedCompleteData3.csv")
