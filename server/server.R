# Server logic
server <- function(input, output) {
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
  
  
}