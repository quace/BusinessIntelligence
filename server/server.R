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
      Name=c("overallrating",
             "potential",
             "price"),
      Value = as.character(c(input$attributeoverallrating,
                             input$attributepotential,
                             input$attributeprice)),
      stringsAsFactors=FALSE
    )
  })
  
  output$values <- renderTable({
    POsliderValues()
  })
  
  #######################
  #BRM
  output$popularitytable = DT::renderDataTable({popularity})
  
  #output$playerImages <- shiny::renderDataTable(playerImageTable,escape=FALSE)
  output$playerImages <- shiny::renderDataTable(htmlExtendedPopularPlayers,escape=FALSE)
  
  #######################
  
  
}