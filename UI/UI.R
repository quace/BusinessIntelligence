#import separate UI pages
source("UI/BRMUI.R")
source("UI/POUI.R")
source("UI/TUI.R")
source("UI/TAUI.R")
source("UI/PPUI.R")

ui <- navbarPage("Soccer Analysis",
                 theme = shinythemes::shinytheme("flatly"),
                 POtabPanel
                 ,
                # tabPanel("Player performance", sidebarLayout( sidebarPanel(selectInput("playernameperf", label = "Select player:",choices = c(),selected=NULL),selectInput("performanceSel", label = "Select performance indicator:",choices = c("overall_rating","potential"),selected=NULL), sliderInput("zoomPlayerPerf",label="Y-axis zoom: ",min=0,max=100,value=c(0,100))), mainPanel(plotOutput("personalperformance"), plotOutput("homeMatchesByPlayer"),plotOutput("awayMatchesByPlayer")) )),
                 navbarMenu("Player Performance", 
                            GPtabPanel,
                            AttrtabPanel,
                            StartabPanel),
                 navbarMenu("Transfer Advice",
                            LAStabPanel,
                            AtabPanel),
                 navbarMenu("Brand-related Marketing",
                            BRMPlayerPanel,
                            BRMTeamPanel),
                 tabPanel("Sentiment Analysis", 
                          sidebarLayout(
                            sidebarPanel = TwitterSidebarPanel,
                            
                            mainPanel = TwitterMainPanel)),
                 inverse=TRUE
)
  
  
 