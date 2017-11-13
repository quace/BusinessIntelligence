#import separate UI pages
source("UI/BRMUI.R")
source("UI/POUI.R")
source("UI/TUI.R")

ui <- navbarPage("Soccer Analysis",
                 theme = shinythemes::shinytheme("flatly"),
                 tabPanel("Player Overview",
                          sidebarLayout(
                            sidebarPanel = POSidebarPanel,
                            mainPanel = POMainPanel
                          )
                 ),
                 tabPanel("Twitter", 
                          sidebarLayout(
                            sidebarPanel = TwitterSidebarPanel,
                            
                            mainPanel = TwitterMainPanel)),
                 tabPanel("Player performance"),
                 tabPanel("Loan/Sell"),
                 tabPanel("Brand-related Marketing",
                          sidebarLayout(
                            sidebarPanel = BRMSidebarPanel,
                           
                            mainPanel = BRMMainPanel
                          )),
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