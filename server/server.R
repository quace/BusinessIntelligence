# Server logic
server <- function(input, output) {
  
  output$playerstatstable = DT::renderDataTable({
    mtcars
  })
  
  
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