library(RSQLite)

con <- dbConnect(drv=RSQLite::SQLite(), dbname="loaddata/soccer.sqlite")

alltables = dbListTables(con)

matches <- dbReadTable(con, "Match")
leagues <- dbReadTable(con, "League")
countries <- dbReadTable(con, "Country")

player <- dbReadTable(con, "Player")
player_attributes <- dbReadTable(con, "Player_Attributes")

team <- dbReadTable(con, "Team")
team_attributes <- dbReadTable(con, "Team_Attributes")

dbDisconnect(con)