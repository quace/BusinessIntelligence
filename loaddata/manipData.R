#PACE
MergeCompleteData <- MergeCompleteData %>% mutate(Pace = as.integer(0.45*Acceleration + 0.55*Speed))

#Shooting
MergeCompleteData <- MergeCompleteData %>% mutate(Shooting = as.integer(0.05*Attacking_Position + 0.45*Finishing +0.20*Shot_Power +0.20*Long_Shots + 0.05*Volleys + 0.05*Penalties))


MergeCompleteData <- MergeCompleteData %>% mutate(Passing = as.integer(0.2*Vision + 0.2*Crossing + 0.05*Freekick_Accuracy + 0.35*Short_Pass + 0.15*Long_Pass + 0.05*Curve))

MergeCompleteData <- MergeCompleteData %>% mutate(Dribblingx = as.integer(0.1*Agility + 0.05*Balance + 0.05*Reactions + 0.3*Ball_Control + 0.5*Dribbling))

MergeCompleteData <- MergeCompleteData %>% mutate(Defending = as.integer(0.2*Interceptions + 0.1*Heading + 0.3*Marking + 0.3*Standing_Tackle + 0.1*Sliding_Tackle))

MergeCompleteData <- MergeCompleteData %>% mutate(Physicality = as.integer(0.05*Jumping + 0.25*Stamina + 0.5*Strength + 0.2*Aggression))

MergeCompleteData <- MergeCompleteData %>% mutate(GK_Score = as.integer((GK_Positioning + GK_Diving + GK_Kicking + GK_Handling + GK_Reflexes )/5))
