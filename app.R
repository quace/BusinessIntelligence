#Main application source file,
#Run this to run the app

# Load packages ----
library(shiny)
library(quantmod)
library(DT)

#load the database
#source("loaddata/load_soccer_data.R")

# Source helpers ----
source("helpers/helpers.R")

# User interface ----
source("UI/UI.R")

source("server/server.R")


# Run the app
shinyApp(ui, server)
