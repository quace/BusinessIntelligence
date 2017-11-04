# Server logic
server <- function(input, output) {
  #PO
  output$playerstatstable = DT::renderDataTable({
    playerStats
  })
  
  #BRM
  output$popularitytable = DT::renderDataTable({popularity})
  #output$myImage <- renderText({c('<img src="https://cdn.futbin.com/content/fifa18/img/clubs/73.png">')})
  #TEST
  playerImageTable <- data.frame(a=c("https://cdn.futbin.com/content/fifa18/img/players/192774.png?v=2","https://cdn.futbin.com/content/fifa18/img/players/203551.png?v=2","https://cdn.futbin.com/content/fifa18/img/players/200104.png?v=2"))
  playerImageTable$a <-sprintf("<img src='%s'>",playerImageTable$a)  
  #x<-data.frame(a=c("<img src='https://cdn.futbin.com/content/fifa18/img/players/200104.png?v=2'>","vassri asdf asdfasdf","csdasdsriasfasf"))
  #x$a<-gsub("sri",'<strong style="color:red">sri</strong>',x$a)
  
  output$playerImages <- shiny::renderDataTable(playerImageTable,escape=FALSE)
  #######################
  
  #TODO: delete all that follows
  
  dataInput <- reactive({
    getSymbols(input$symb, src = "google", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  finalInput <- reactive({
    if(!input$adjust) return(dataInput())
    adjust(dataInput())
  })
  
  output$plot <- renderPlot({
    plot(cars, type=input$plotType)
  })
  
}