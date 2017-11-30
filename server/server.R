# Server logic

server <- function(input, output, session) {
  #dynamically suggest playernames
  test1 <- data.frame("Name" = c("All Players"))
  test2 <- data.frame("Name" = fullData$Name)
  choicesPlayer <- rbind(test1,test2)
  updateSelectInput(session, "playername", "Search player: ", choices = choicesPlayer$Name)
  test1 <- data.frame("Name" = c(""))
  test2 <- data.frame("Name" = fullData$Club)
  choicesClub <- rbind(test1,test2)
  updateSelectInput(session, "clubname", "Search club: ", choices = choicesClub$Name)
  test1 <- data.frame("Name" = c("Country"))
  test2 <- data.frame("Name" = fullData$Nationality)
  choicesCountry <- rbind(test1,test2)
  updateSelectInput(session, "country", "Search country", choices = choicesCountry$Name)
  test1 <- data.frame("Name" = c("Position"))
  test2 <- data.frame("Name" = fullData$Club_Position)
  choicesPosition <- rbind(test1,test2)
  updateSelectInput(session, "position", "Search position: ", choices = choicesPosition$Name)
  updateSelectInput(session,"TAAPosition",choices=choicesPosition$Name)
 
  test1 <- data.frame("Name" = c(""))
  test2 <- data.frame("Name" = fullData$Name)
  choicesPlayer <- rbind(test1,test2)
  updateSelectInput(session, "BRMPlayer1",choices = choicesPlayer$Name)
  updateSelectInput(session, "BRMPlayer2",choices = choicesPlayer$Name)
  test1 <- data.frame("Name" = c(""))
  test2 <- data.frame("Name" = fullData$Club)
  choicesClub <- rbind(test1,test2)
  updateSelectInput(session, "BRMTeam1",choices = choicesClub$Name)
  updateSelectInput(session, "BRMTeam2",choices = choicesClub$Name)
  
  
  
  test1 <- data.frame("Name" = c(""))
  test2 <- data.frame("Name" = fullData$Club)
  choicesClub <- rbind(test1,test2)
  updateSelectInput(session, "TALASClub",choices = choicesClub$Name)
  updateSelectInput(session, "TAAClub",choices = choicesClub$Name)
  
  
  #PO
  getPODisplayTable <- function(){
    #Player name
    if(input$POsearchfunction == 1){
      return(getPOTablePlayerName(input$playername))
     # return (playerStats)
    }
    #Club
    else if(input$POsearchfunction == 2){
      if(!input$clubname == ""){
      return(getPOTableClub(input$clubname))
      }
      
    }
    #Attributes
    else if(input$POsearchfunction == 3){
      if(input$simplify){
         return(getPOTableAdvanced(input$simplify, POsliderValues(),input$country,input$position,input$preferredfoot))
      }
      else {
        return(getPOTableAdvanced(input$simplify, POEXsliderValues(),input$country,input$position,input$preferredfoot))
        
      }
    }
    else {
      return (playerStats)
    }
    
    
  }
  
    output$playerstatstable <- DT::renderDataTable({
    #playerStats
    getPODisplayTable()
  })
    
  
  
  #search on playername
 # newPlayerNameSearch <- eventReactive(input$searchPlayerName,
  #                                     {
                                         
   #                                    })
  #search attributes using slider values: simplified
  POsliderValues <- reactive({
    slidervalues <- data.frame(
                            "pacemin"=input$attributepace[1],
                            "pacemax"=input$attributepace[2],
             "shootingmin"=input$attributeshooting[1],
             "shootingmax"=input$attributeshooting[2],
             "passingmin"=input$attributepassing[1],
             "passingmax"=input$attributepassing[2],
             "agilitymin"=input$attributeagility[1],
             "agilitymax"=input$attributeagility[2],
             "defendingmin"=input$attributedefending[1],
             "defendingmax"=input$attributedefending[2],
             "physicalitymin"=input$attributephysicality[1],
             "physicalitymax"=input$attributephysicality[2],
             "overallratingmin"=input$attributeoverallrating[1],
             "overallratingmax"=input$attributeoverallrating[2],
             "potentialmin"=input$attributepotential[1],
             "potentialmax"=input$attributepotential[2],
             "pricemin"=input$attributeprice[1],
             "pricemax"=input$attributeprice[2],
             "agemin" = input$attributeage[1],
             "agemax" = input$attributeage[2])
      
    
    return (slidervalues)

  })
  
  #Extented version of the attribute sliders
  POEXsliderValues <- reactive({
    slidervalues <- data.frame(
      "accelerationmin"=input$attributeEXAcceleration[1],
      "accelerationmax"=input$attributeEXAcceleration[2],
      "speedmin"=input$attributeEXSpeed[1],
      "speedmax"=input$attributeEXSpeed[2],
      "attackingposmin"=input$attributeEXAttackingPos[1],
      "attackingposmax"=input$attributeEXAttackingPos[2],
      "finishingmin"=input$attributeEXFinishing[1],
      "finishingmax"=input$attributeEXFinishing[2],
      "shotpowermin"=input$attributeEXShotPower[1],
      "shotpowermax"=input$attributeEXShotPower[2],
      "longshotsmin"=input$attributeEXLongShots[1],
      "longshotsmax"=input$attributeEXLongShots[2],
      "volleysmin"=input$attributeEXVolleys[1],
      "volleysmax"=input$attributeEXVolleys[2],
      "penaltiesmin"=input$attributeEXPenalties[1],
      "penaltiesmax"=input$attributeEXPenalties[2],
      "visionmin"=input$attributeEXVision[1],
      "visionmax"=input$attributeEXVision[2],
      "crossingmin" = input$attributeEXCrossing[1],
      "crossingmax" = input$attributeEXCrossing[2],
      "fkaccuracymin"=input$attributeEXFKAccuracy[1],
      "fkaccuracymax"=input$attributeEXFKAccuracy[2],
      "shortpassmin"=input$attributeEXShortPass[1],
      "shortpassmax"=input$attributeEXShortPass[2],
      "longpassmin"=input$attributeEXLongPass[1],
      "longpassmax"=input$attributeEXLongPass[2],
      "curvemin"=input$attributeEXCurve[1],
      "curvemax"=input$attributeEXCurve[2],
      "agilitymin"=input$attributeEXAgility[1],
      "agilitymax"=input$attributeEXAgility[2],
      "balancemin"=input$attributeEXBalance[1],
      "balancemax"=input$attributeEXBalance[2],
      "reactionsmin" = input$attributeEXReactions[1],
      "reactionsmax" = input$attributeEXReactions[2],
      "ballcontrolmin" = input$attributeEXBallControl[1],
      "ballcontrolmax" = input$attributeEXBallControl[2],
      "dribblingmin"=input$attributeEXDribbling[1],
      "dribblingmax"=input$attributeEXDribbling[2],
      "composuremin"=input$attributeEXComposure[1],
      "composuremax"=input$attributeEXComposure[2],
      "interceptionsmin"=input$attributeEXInterceptions[1],
      "interceptionsmax"=input$attributeEXInterceptions[2],
      "headingmin"=input$attributeEXHeading[1],
      "headingmax"=input$attributeEXHeading[2],
      "markingmin"=input$attributeEXMarking[1],
      "markingmax"=input$attributeEXMarking[2],
      "standingtacklemin"=input$attributeEXStandingTackle[1],
      "standingtacklemax"=input$attributeEXStandingTackle[2],
      "slidingtacklemin" = input$attributeEXSlidingTackle[1],
      "slidingtacklemax" = input$attributeEXSlidingTackle[2],
      "jumpingmin"=input$attributeEXJumping[1],
      "jumpingmax"=input$attributeEXJumping[2],
      "staminamin"=input$attributeEXStamina[1],
      "staminamax"=input$attributeEXStamina[2],
      "strengthmin"=input$attributeEXStrength[1],
      "strengthmax"=input$attributeEXStrength[2],
      "aggressionmin" = input$attributeEXAggression[1],
      "aggressionmax" = input$attributeEXAggression[2],
      "overallratingmin"=input$attributeoverallrating[1],
      "overallratingmax"=input$attributeoverallrating[2],
      "potentialmin"=input$attributepotential[1],
      "potentialmax"=input$attributepotential[2],
      "pricemin"=input$attributeprice[1],
      "pricemax"=input$attributeprice[2],
      "agemin" = input$attributeage[1],
      "agemax" = input$attributeage[2])
    
    
    return (slidervalues)
    
  })
  
  output$values <- renderTable({
    POsliderValues()
  })

  #######################
  #######################
  
  #personal performance
  
  ######################
  ######################
  
  updateSelectInput(session, "playernameperf", "Search player: ", choices = player$player_name)
  updateSelectInput(session, "compareplayerperf", "Compare with: ", choices = player$player_name)
  updateSelectInput(session, "playernameAttr", "Search player: ", choices = player$player_name)
  updateSelectInput(session, "compareplayerAttr", "Compare with: ", choices = player$player_name)
  
  #### General/Potential ####
  output$personalperformance <- renderPlot({
    
    selectedplayer <- player %>% filter(player_name == input$playernameperf)
    compareplayer <- player %>% filter(player_name == input$compareplayerperf)
    api_id <- selectedplayer$player_api_id
    compare_id <- compareplayer$player_api_id
    selectedPerf <- input$performanceSel
    
    yminimum <- as.integer(input$zoomPlayerPerf[1])
    ymaximum <- as.integer(input$zoomPlayerPerf[2])
    ybreaks <- as.integer(input$zoomPlayerPerf/10)
    
    plot <- player_attributes %>%
      left_join(player, by = "player_api_id") %>%
      filter(player_api_id == api_id | player_api_id == compare_id) %>%
      select(player_name, date, selectedPerf) %>%
      mutate(date = substring(date, 0, 10)) %>%
      ggplot(aes_string("date", selectedPerf, color = "player_name", group = "player_name")) +
      geom_line() +
      geom_point() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      geom_text(aes_string(label = selectedPerf),color = "red", vjust = 2) +
      coord_cartesian(ylim = c(yminimum, ymaximum)) 
    
    return(plot)
  })
  
  getHomeMatchesByPlayer <- function(playername){
    selectedplayer <- player %>% filter(player_name == playername)
    api_id <- selectedplayer$player_api_id
    matchesOfPlayerX <- matches %>% select(id, date, home_team_api_id, season, home_team_goal, home_player_1:home_player_11) %>% gather(position, playerid,  home_player_1:home_player_11) %>% merge(team, all= T) %>% merge(player, all = T) %>% filter(playerid == api_id) %>% group_by(season) %>% ggplot(aes(x= season, y= home_team_goal)) + geom_boxplot() + theme(axis.text.x = element_text(angle = 90, hjust = 1))
    return(matchesOfPlayerX)
  }
  getAwayMatchesByPlayer <- function(playername){
    selectedplayer <- player %>% filter(player_name == playername)
    api_id <- selectedplayer$player_api_id
    matchesOfPlayerX <- matches %>% select(id, date, away_team_api_id, season, away_team_goal, away_player_1:away_player_11) %>% gather(position, playerid,  away_player_1:away_player_11) %>% merge(team, all= T) %>% merge(player, all = T) %>% filter(playerid == api_id) %>% group_by(season) %>% ggplot(aes(x= season, y= away_team_goal)) + geom_boxplot() + theme(axis.text.x = element_text(angle = 90, hjust = 1))
    return(matchesOfPlayerX)
  }
  output$homeMatchesByPlayer <- renderPlot({getHomeMatchesByPlayer(input$playernameperf)})
  output$awayMatchesByPlayer <- renderPlot({getAwayMatchesByPlayer(input$playernameperf)})
  
  #### Attributes ####
  output$attributePP <- renderPlot({
    
    selectedAttrPlayer <- player %>% filter(player_name == input$playernameAttr)
    compareAttrPlayer <- player %>% filter(player_name == input$compareplayerAttr)
    api_id <- selectedAttrPlayer$player_api_id
    compare_id <- compareAttrPlayer$player_api_id
    selectedAttr <- input$attribute
    
    yminimum <- as.integer(input$zoomPlayerAttr[1])
    ymaximum <- as.integer(input$zoomPlayerAttr[2])
    ybreaks <- as.integer(input$zoomPlayerAttr/10)
    
    plot2 <- player_attributes %>%
      left_join(player, by = "player_api_id") %>%
      filter(player_api_id == api_id | player_api_id == compare_id) %>%
      select(player_name, date, selectedAttr) %>%
      mutate(date = substring(date, 0, 10)) %>%
      ggplot(aes_string("date", selectedAttr, color = "player_name", group = "player_name")) +
      geom_line() +
      geom_point() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      geom_text(aes_string(label = selectedAttr),color = "red", vjust = 2) +
      coord_cartesian(ylim = c(yminimum, ymaximum)) 
    
    return(plot2)
  })
  
  ### Eden Hazard ###
  # output$starPP <- renderPlot({
  #   
  #   selectedStarPlayer <- player %>% filter(player_name == input$playernameStar)
  #   compareStarPlayer <- player %>% filter(player_name == "Eden Hazard")
  #   api_id <- selectedStarPlayer$player_api_id
  #   compare_id <- compareStarPlayer$player_api_id
  #   selectedStarAttr <- input$attributeStar
  #   
  #   yminimum <- as.integer(input$zoomPlayerPerf[1])
  #   ymaximum <- as.integer(input$zoomPlayerPerf[2])
  #   ybreaks <- as.integer(input$zoomPlayerPerf/10)
  #   
  #   plot3 <- player_attributes %>%
  #     left_join(player, by = "player_api_id") %>%
  #     filter(player_api_id == api_id | player_api_id == compare_id) %>%
  #     select(player_name, date, selectedStarAttr) %>%
  #     mutate(date = substring(date, 0, 10)) %>%
  #     ggplot(aes_string("date", selectedStarAttr, color = "player_name", group = "player_name")) +
  #     geom_line() +
  #     geom_point() +
  #     theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  #     geom_text(aes_string(label = selectedStarAttr),color = "red", vjust = 2)
  #   return(plot3)
  # })
  # 
  #######################
  #BRM
  # output$popularitytable = DT::renderDataTable({popularity})
  # 
  # #output$playerImages <- shiny::renderDataTable(playerImageTable,escape=FALSE)
  # output$playerImages <- shiny::renderDataTable(htmlExtendedPopularPlayers,escape=FALSE)
  # 
  
  #PLAYERS
  output$facebookFollowersP1 <- renderText({getFacebookLikes(input$BRMPlayer1)})
  output$facebookFollowersP2 <- renderText({getFacebookLikes(input$BRMPlayer2)})
  output$twitterFollowersP1 <- renderText({getFacebookTalkingAbout(input$BRMPlayer1)})
  output$twitterFollowersP2 <- renderText({getFacebookTalkingAbout(input$BRMPlayer2)})
  #output$instagramFollowersP1 <- renderText({"154893"})
  #output$instagramFollowersP2 <- renderText({"134876"})
  
  output$followerWorthP1 <- renderText({"87549600"})
  
  output$followerWorthP2 <- renderText({"87946320"})
  
  #TEAMS
  output$facebookFollowersT1 <- renderText({getFacebookLikes(input$BRMTeam1)})
  output$facebookFollowersT2 <- renderText({getFacebookLikes(input$BRMTeam2)})
  output$twitterFollowersT1 <- renderText({getFacebookTalkingAbout(input$BRMTeam1)})
  output$twitterFollowersT2 <- renderText({getFacebookTalkingAbout(input$BRMTeam2)})
  output$followerWorthT1 <- renderText({"87549600"})
  
  output$followerWorthT2 <- renderText({"87946320"})
  
  
  #######################
  #######################
  
  #TWITTER
  
  ######################
  ######################
  
  updateSelectInput(session, "twitterSearchterm", "Search player: ", choices = player$player_name)
  
    source("APIs/GlobalTwitter.R")

    token <- get("oauth_token", twitteR:::oauth_cache) #Save the credentials info
    token$cache()
    
    output$currentTime <- renderText({invalidateLater(1000, session) 
    paste("Time: ",Sys.time())})
    
      tweets <- reactive({
        tweets <- getTweets(input$twitterSearchterm, n = input$numberOfTweets, input$retweetsBool) #tweets = df
        return(tweets)
      })
      
      output$tweetCount  <- renderText({
        withProgress(message = 'Searching tweets...', value = 0, {
        df <- tweets()
        paste("Number of Tweets Found: ", as.character(nrow(df)))
        })
      })
      
      cleantweets <- reactive({ #clean tweets for sentiment analysis
        cleantweets <- cleanTweets(tweets())
        return(cleantweets)
      })
      
      sentiments <- reactive({
        sentiments <- getSentiments(cleantweets()$text)
        sentiments <- data.frame(sentiments)
        sentiments <- sentiments %>% summarise(anger = sum(anger),
                                anticipation = sum(anticipation),
                                disgust = sum(disgust),
                                fear = sum(fear),
                                joy = sum(joy),
                                sadness = sum(sadness),
                                surprise = sum(surprise),
                                trust = sum(trust),
                                positivity = sum(positivity))
        sentiments <- sentiments %>% gather(emotion,score, anger:positivity)
        sentiments$score[1] <- sentiments$score[1]/sum(sentiments$score)
        sentiments$score[2] <- sentiments$score[2]/sum(sentiments$score)
        sentiments$score[3] <- sentiments$score[3]/sum(sentiments$score)
        sentiments$score[4] <- sentiments$score[4]/sum(sentiments$score)
        sentiments$score[5] <- sentiments$score[5]/sum(sentiments$score)
        sentiments$score[6] <- sentiments$score[6]/sum(sentiments$score)
        sentiments$score[7] <- sentiments$score[7]/sum(sentiments$score)
        sentiments$score[8] <- sentiments$score[8]/sum(sentiments$score)
        sentiments$score[9] <- sentiments$score[9]/sum(sentiments$score)
        return(sentiments)
      })
      
      output$tablesentiments <- renderTable(sentiments())
      
      output$sentimentTable <- renderPlot({ withProgress(message = 'Searching tweets...', value = 0, {ggplot(sentiments(), aes(emotion, score)) + geom_bar(stat = "identity")})})
 
      
######################################################
#Transfer Advice
######################################################
      getLoanAndSellTable <- function(){
        if(!(input$TALASClub == "")){
        return(constructLoandSellTable(input$TALASClub))
        }
      }
      
      
      output$loanandselltable <- shiny::renderDataTable(getLoanAndSellTable(),escape=FALSE
      )
      
      output$reasonLoan <- renderText({"Rating is below average but \npotential is high"})
      output$reasonAttackingPos <- renderText({"Attacking technique is below average"})
      output$reasonWage <- renderText({"Player is overpayed"})
      output$reasonValue <- renderText({"Sell player for more \nthan they're worth"})
      output$reasonContract <- renderText({"Contract will soon expire"})
      output$reasonAge <- renderText({"Player is getting old \n(Keep in mind that he might be a \ngood tutor for younger players!)"})
      output$reasonAttackingPos2 <- renderText({"Above average attacking technique"})
      output$reasonWage2 <- renderText({"Player is underpayed"})
      output$reasonValue2 <- renderText({"Player is worth more \nthan currently valued"})
      output$reasonAge2 <- renderText({"Player is young"})
      output$reasonContract2 <- renderText({"Contract will soon expire"})
      
      
      getAcquireTable <- function(){
        if(!(input$TAAClub == "")){
          return(constructAcquireTable(input$TAAClub,input$TAAPosition, input$TAAPricerange[1], input$TAAPricerange[2]))
        }
      }
    output$acquiretable <- shiny::renderDataTable(getAcquireTable(),escape = FALSE)
      
      
}
