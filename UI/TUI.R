#Twitter UI
TwitterSidebarPanel <-  sidebarPanel(
            textOutput("currentTime"),
             textInput("TwitterSearchterm", 
                       value = "Iniesta", 
                       #value = "",
                       label = "Search: ", 
                       placeholder = "Enter what you're searching for"),
             textOutput("tweetssel"))


TwitterMainPanel <-  mainPanel(plotlyOutput("twittergraph"),
          
          verbatimTextOutput("event"))