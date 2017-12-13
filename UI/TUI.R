#Twitter UI
TwitterSidebarPanel <-  sidebarPanel(
            textOutput("currentTime"),
            selectInput("twitterSearchterm", "Player 1:", choices = c()),
            selectInput("twitterSearchterm2", "Player 2:", choices = c()),
            numericInput("numberOfTweets", label = "Max number of tweets", value = 100),
            checkboxInput("retweetsBool", "No retweets?", value = FALSE, width = NULL), hr(),
            textOutput("tweetCount"))
      
TwitterMainPanel <-  mainPanel( fluidPage(
  fluidRow(
    column(12, h3("Twitter"))
  ),
  fluidRow(
    column(12, h5("Player 1"))
  ),
  fluidRow(
    column(9,
           plotOutput("sentimentTable")
    ),
    column(3,tableOutput("tablesentiments"))),
  fluidRow(
    column(12, h5("Player 2"))
  ),
  fluidRow(
    column(9,
           plotOutput("sentimentTable2")
    ),
    column(3,tableOutput("tablesentiments2")))
)
)
  
  
 # h3("Twitter"),plotOutput("sentimentTable"),tableOutput("tablesentiments"))