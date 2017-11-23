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
 # updateSelectInput(session, "league", "Search league: ", choices = fullData$Club)
  
  
  
  
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
      return(getPOTableAdvanced(POsliderValues(),input$country,input$position,input$preferredfoot))
     
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
  #search attributes using slider values
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
  
  output$values <- renderTable({
    POsliderValues()
  })

  #######################
  #######################
  
  #personal performance
  
  ######################
  ######################
  
  updateSelectInput(session, "playernameperf", "Search player: ", choices = player$player_name)
  
  output$personalperformance <- renderPlot({
    
    selectedplayer <- player %>% filter(player_name == input$playernameperf)
    api_id <- selectedplayer$player_api_id
    selectedPerf <- input$performanceSel
    
    yminimum <- as.integer(input$zoomPlayerPerf[1])
    ymaximum <- as.integer(input$zoomPlayerPerf[2])
    ybreaks <- as.integer(input$zoomPlayerPerf/10)
    
    plot <- player_attributes %>%
      filter(player_api_id == api_id) %>%
      ggplot(aes_string("date",selectedPerf,group=1)) + geom_point() + geom_line() + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + geom_text(aes_string(label = selectedPerf),color = "red", vjust = 2) + coord_cartesian(ylim = c(yminimum, ymaximum))
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
  
  
  #######################
  #BRM
  output$popularitytable = DT::renderDataTable({popularity})
  
  #output$playerImages <- shiny::renderDataTable(playerImageTable,escape=FALSE)
  output$playerImages <- shiny::renderDataTable(htmlExtendedPopularPlayers,escape=FALSE)
  
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
      
}
