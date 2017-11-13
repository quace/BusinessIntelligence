# Server logic
getMatchesByPlayer <- function(playername){
  test <- matches  %>% select(id, date, home_team_api_id, season, home_team_goal, home_player_1:home_player_11) %>% gather(position, playerid,  home_player_1:home_player_11) %>% merge(team, all= T) %>% merge(player, all = T) %>% filter(playerid == 2625) %>% group_by(id) %>% ggplot(aes(x= season, y= home_team_goal)) + geom_boxplot()   +theme(axis.text.x = element_text(angle = 90, hjust = 1))
  matchesOfPlayerX <- matches  %>% select(id, date, home_team_api_id, season, home_team_goal, home_player_1:home_player_11) %>% gather(position, playerid,  home_player_1:home_player_11) %>% merge(team, all= T) %>% merge(player, all = T) %>% filter(player_name == playername) %>% group_by(id) %>% ggplot(aes(x= season, y= home_team_goal)) + geom_boxplot()   +theme(axis.text.x = element_text(angle = 90, hjust = 1))
  matchesOfPlayerX <- test
  return(matchesOfPlayerX)
}

server <- function(input, output, session) {
  #PO
  getPODisplayTable <- function(){
    #Player name
    if(input$POsearchfunction == 1){
      return(getPOTablePlayerName(input$playername))
     # return (playerStats)
    }
    #Club
    else if(input$POsearchfunction == 2){
      return(getPOTableClub(input$clubname))
      
    }
    #Attributes
    else if(input$POsearchfunction == 3){
      return(getPOTableAttributes(POsliderValues()))
     
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
    slidervalues <- data.frame("overallratingmin" = input$attributeoverallrating[1],
                            "overallratingmax"=input$attributeoverallrating[2],
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
             "pricemax"=input$attributeprice[2])
      
    
    return (slidervalues)
  })
  
  output$values <- renderTable({
    POsliderValues()
  })
  

  
  
  output$matchesByPlayer <- renderPlot({getMatchesByPlayer(input$playername)})

  
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
    paste("Current time is: ",Sys.time(), "!Beware: Twitter doesn't return tweets older than a week through the search api.")})
    
      tweets <- reactive({
        tweets <- getTweets(input$twitterSearchterm, n = input$numberOfTweets, input$retweetsBool) #tweets = df
        return(tweets)
      })
      
      output$tweetCount  <- renderText({
        df <- tweets()
        paste("Number of Tweets Found: ", as.character(nrow(df)))
      })
      
      output$table <- renderTable({
        tweets()
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
                                negative = sum(negative),
                                positive = sum(negative),
                                positivity = sum(positivity))
        sentiments <- sentiments %>% gather(emotion,score, anger:positivity)
        return(sentiments)
      })
      
      output$tablesentiments <- renderTable(sentiments())
      
      output$sentimentTable <- renderPlot({ggplot(sentiments(), aes(emotion, score)) + geom_bar(stat = "identity")})
      
}
