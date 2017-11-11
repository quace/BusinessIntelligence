# Server logic
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
  newPlayerNameSearch <- eventReactive(input$searchPlayerName,
                                       {
                                         
                                       })
  #search attributes using slider values
  POsliderValues <- reactive({
    data.frame(
      Name=c("pace",
             "shooting",
             "passing",
             "agility",
             "defending",
             "physicality",
             "overallrating",
             "potential",
             "price"),
      Value = as.character(c(input$pace,
                             input$shooting,
                             input$passing,
                             input$agility,
                             input$defending,
                             input$physicality,
                            input$attributeoverallrating,
                             input$attributepotential,
                             input$attributeprice)),
      stringsAsFactors=FALSE
    )
  })
  
  output$values <- renderTable({
    POsliderValues()
  })
  
  output$matchesByPlayer <- renderPlot({matches  %>% select(id, date, home_team_api_id, season, home_team_goal, home_player_1:home_player_11) %>% gather(position, playerid,  home_player_1:home_player_11) %>% merge(team, all= T) %>% merge(player, all = T) %>% filter(playerid == 2625) %>% group_by(id) %>% ggplot(aes(x= season, y= home_team_goal)) + geom_boxplot()   +theme(axis.text.x = element_text(angle = 90, hjust = 1))
})
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
    secrets <- rjson::fromJSON(file='scrapers/twitter_secrets.json.nogit')
    
    setup_twitter_oauth(secrets$api_key,
                        secrets$api_secret,
                        secrets$access_token,
                        secrets$access_token_secret)
    token <- get("oauth_token", twitteR:::oauth_cache) #Save the credentials info
    token$cache()
    output$currentTime <- renderText({invalidateLater(1000, session) 
      paste("Current time is: ",Sys.time())})
    
    tweetssearchterm <- renderText({ input$searchTerm })
    
    tweets <- searchTwitter(tweetssearchterm, n=1000, lang="en", since="2014-08-20")
    
    tweets.df <- twListToDF(tweets)
    
    sentimentOfTweet <- get_nrc_sentiment(tweets.df$text)
    
    g <- ggplot(data = tweets.df, aes(x = timestamp)) +
      geom_histogram(aes(fill = ..count..)) +
      theme(legend.position = "none") +
      xlab("Time") + ylab("Number of tweets") + 
      scale_fill_gradient(low = "midnightblue", high = "aquamarine4")
    
    output$twittergraph <- ggplotly(g, tooltip=c("Timestamp","Count"))
    
    output$event <- renderPrint({
      d <- event_data("plotly_hover")
      if (is.null(d)) "Hover on a point!" else d
    })
}
