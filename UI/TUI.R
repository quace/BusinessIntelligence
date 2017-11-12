#Twitter UI
TwitterSidebarPanel <-  sidebarPanel(
            textOutput("currentTime"),
            selectInput("twitterSearchterm", "Search:", choices = c()),
            numericInput("numerOfTweets", label = "Max number of tweets", value = 100),hr(),
            textOutput("tweetCount"))
      
TwitterMainPanel <-  mainPanel(tableOutput("table"), plotOutput("wordcloud"))