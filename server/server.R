# Server logic
server <- function(input, output) {
  #PO
  output$playerstatstable = DT::renderDataTable({
    playerStats
  })
  
  
  
  #######################
  #BRM
  output$popularitytable = DT::renderDataTable({popularity})
  
  #output$playerImages <- shiny::renderDataTable(playerImageTable,escape=FALSE)
  output$playerImages <- shiny::renderDataTable(htmlExtendedPopularPlayers,escape=FALSE)
  
  #######################
  
  
}