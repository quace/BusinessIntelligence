#Twitter UI
TwitterSidebarPanel <-  sidebarPanel(
            textOutput("currentTime"),
            selectInput("twitterSearchterm", "Search:", choices = c()),
            numericInput("numberOfTweets", label = "Max number of tweets", value = 100),
            checkboxInput("retweetsBool", "No retweets?", value = FALSE, width = NULL), hr(),
            textOutput("tweetCount"))
      
TwitterMainPanel <-  mainPanel( h3("Twitter"),plotOutput("sentimentTable"),tableOutput("tablesentiments"))