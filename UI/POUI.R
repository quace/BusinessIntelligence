#Player Overview UI

POSidebarPanel <-  sidebarPanel(
  #  helpText("Select a club"),
  selectInput("selectclubstats",label=h3("Select a club"),
              choices = list("Show all clubs" = 1, "Club 2" = 2, "Club 3" = 3),
              selected = 1)
)

POMainPanel <-  mainPanel(
  DT::dataTableOutput("playerstatstable")
)