ui <- navbarPage("Soccer Analysis",
                 tabPanel("Player Overview",
                          sidebarLayout(
                            sidebarPanel(
                             # helpText("Type the name of a player to see their statistics."),
                            #  textInput("playernamestats",label=h3("Player name"),value="")
                              
                            ),
                            mainPanel(
                              DT::dataTableOutput("playerstatstable")
                            )
                          )
                 ),
                 
                 
                 tabPanel("Match Advise"),
                 tabPanel("Loan/Sell"),
                 tabPanel("Ideal Team"),
                 tabPanel("Brand-related Marketing"),
                 inverse=TRUE
                 
)
  
  
  
 # fluidPage(
#  titlePanel("stockVis"),
  
  #sidebarLayout(
    #sidebarPanel(
    #  helpText("Select a stock to examine. 
     #          Information will be collected from Google finance."),
      
    #  textInput("symb", "Symbol", "SPY"),
      
    #  dateRangeInput("dates", 
     #                "Date range",
    #                 start = "2013-01-01", 
   #                  end = as.character(Sys.Date())),
      
  #    br(),
 #     br(),
      
#      checkboxInput("log", "Plot y axis on log scale", 
      #              value = FALSE),
      
     # checkboxInput("adjust", 
    #                "Adjust prices for inflation", value = FALSE)
   #   ),
    
  #  mainPanel(plotOutput("plot"))
 # )
#)