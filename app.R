
#Main application source file,
#Run this to run the app

# Load packages ----

#source("libraries.R")


#load the database
#source("loaddata/load_soccer_data.R")
source("loaddata/load_full_data.R")


#scrape data
#source("scrapers/scrapers.R")

# Source helpers ----
source("helpers/helpers.R")
# User interface ----

source("UI/UI.R")

source("server/server.R")

# Run the app
shinyApp(ui, server)