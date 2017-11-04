#Brand Related Marketing UI

BRMSidebarPanel <- sidebarPanel()

BRMMainPanel <-  mainPanel (
  tabsetPanel(
    tabPanel("Plot", plotOutput("plot")), 
    tabPanel("Summary", verbatimTextOutput("summary")), 
    tabPanel("Table", tableOutput("table"))
  )
)