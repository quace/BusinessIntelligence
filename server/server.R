# Server logic
server <- function(input, output) {
  #PO
  output$playerstatstable = DT::renderDataTable({
    playerStats
  })
  
  
  POsliderValues <- reactive({
    data.frame(
      Name=c("attributeoverallrating",
             "attributepotential",
             "attributeprice"),
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