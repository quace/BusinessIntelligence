#Twitter UI
TwitterSidebarPanel <-  sidebarPanel(
            textOutput("currentTime"),
            selectInput("twitterSearchterm", "Search:", choices = c()),
            numericInput("numberOfTweets", label = "Max number of tweets", value = 100),
            checkboxInput("retweetsBool", "No retweets?", value = FALSE, width = NULL), hr(),
            textOutput("tweetCount"),
            tableOutput("tablesentiments"))
      
TwitterMainPanel <-  mainPanel( plotOutput("sentimentTable"), tableOutput("table"))