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
names <- xpathSApply(hh,'//*[@id="Player-card"]/div[3]',xmlValue)
pictures <- xpathSApply(hh, '//*[@id="player_pic"]',xmlGetAttr,'src')