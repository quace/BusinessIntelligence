#Twitter UI
TwitterSidebarPanel <-  sidebarPanel(
            textOutput("currentTime"),
            selectInput("twitterSearchterm", "Search:", choices = c()),
            numericInput("numberOfTweets", label = "Max number of tweets", value = 100),
            checkboxInput("retweetsBool", "No retweets?", value = FALSE, width = NULL), hr(),
            textOutput("tweetCount"))
      
TwitterMainPanel <-  mainPanel( fluidPage(
  fluidRow(
    column(12, h3("Twitter"))
  ),
  fluidRow(
    column(9,
           plotOutput("sentimentTable")
    ),
    column(3,tableOutput("tablesentiments")))
)
)
  
  
 # h3("Twitter"),plotOutput("sentimentTable"),tableOutput("tablesentiments"))