library("rvest")
library(XML)

#Scrape the most popular players
url2 <- "https://www.futbin.com/popular"
popular <- url2 %>%
  html() %>%
  html_nodes(xpath='
             /html/body/div[7]/div[4]/ul') 
#%>%
# html_text()


hh <- htmlParse(popular,asText=T)

#use xpath to extract data
#TODO: weird symbols in name -> fix this asap
names <- xpathSApply(hh,'//*[@id="Player-card"]/div[3]',xmlValue)
pictures <- xpathSApply(hh, '//*[@id="player_pic"]',xmlGetAttr,'src')
ratings <- xpathSApply(hh,'//*[@id="Player-card"]/div[2]',xmlValue)
countrypics <- xpathSApply(hh,'//*[@id="player_nation"]',xmlGetAttr,'src')
clubpics <- xpathSApply(hh,'//*[@id="player_club"]',xmlGetAttr,'src')
positions <- xpathSApply(hh,'//*[@id="Player-card"]/div[4]',xmlValue)

#TODO: transform prices to actual numbers
ps_prices <- xpathSApply(hh,'//*[@class="ps_main_price"]',xmlValue)
xbox_prices <- xpathSApply(hh,'//*[@class="xbox_main_price"]',xmlValue)

#TODO: maybe an extra column with the explicit rank? 
#merge everything into 1 dataframe
popularPlayers <- data.frame("name" = names,
                             "rating" = ratings,
                             "picture" = pictures,
                             "country" = countrypics,
                             "club" = clubpics,
                             "position" = positions,
                             "price" = ps_prices)

popularity <- data.frame("name" = popularPlayers$name,
                         "rating"=popularPlayers$rating,
                         "position" = popularPlayers$position,
                         "price" = popularPlayers$price)
