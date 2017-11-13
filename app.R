#Main application source file,
#Run this to run the app

# Load packages ----
library(shiny)
library(quantmod)
library(DT)
library(lubridate)
library(rjson) #R json for OAuth for fb and twitter
library(twitteR) #Getting all tweets into dataframes
library(tm) #text mining for sentiment analysis
library(syuzhet) #Word-emotion algorithm
library(wordcloud)
library(plotly)
library(scales)
library(shinythemes)

#load the database
source("loaddata/load_soccer_data.R")
source("loaddata/load_full_data.R")

#scrape data
source("scrapers/scrapers.R")

# Source helpers ----
source("helpers/helpers.R")
# User interface ----

source("UI/UI.R")

source("server/server.R")

# Run the app
shinyApp(ui, server)