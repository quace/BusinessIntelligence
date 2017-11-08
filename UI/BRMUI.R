#Brand Related Marketing UI

BRMSidebarPanel <- sidebarPanel()

BRMMainPanel <-  mainPanel (
  tabsetPanel(
    #tabPanel("Visual", shiny::dataTableOutput("playerImages")), 
    tabPanel("Visual", shiny::dataTableOutput("playerImages")), 
    tabPanel("Details",  DT::dataTableOutput("popularitytable"))
    #tabPanel("Table", tableOutput("table"))
  )
)