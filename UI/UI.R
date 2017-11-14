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
                 tabPanel("Player performance", sidebarLayout( sidebarPanel(selectInput("playernameperf", label = "Select player:",choices = c(),selected=NULL),selectInput("performanceSel", label = "Select performance indicator:",choices = c("overall_rating","potential"),selected=NULL), sliderInput("zoomPlayerPerf",label="Y-axis zoom: ",min=0,max=100,value=c(0,100))), mainPanel(plotOutput("personalperformance"), plotOutput("homeMatchesByPlayer"),plotOutput("awayMatchesByPlayer")) )),
                 tabPanel("Twitter", 
                          sidebarLayout(
                            sidebarPanel = TwitterSidebarPanel,
                            
                            mainPanel = TwitterMainPanel)),
                 tabPanel("Brand-related Marketing",
                          sidebarLayout(
                            sidebarPanel = BRMSidebarPanel,
                           
                            mainPanel = BRMMainPanel
                          )),
                 tabPanel("Loan/Sell"),
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