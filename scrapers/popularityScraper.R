

handlePrices <- function(data){
  for(i in 1:length(data)){
    price = data[i]
    if(grepl("K",price)){
      price = substr(price, 1, nchar(price)-1)
      price = as.numeric(price) * 1000
    } else if(grepl("M",price)){
      price = substr(price, 1, nchar(price)-1)
      price = as.numeric(price)*1000000
    }
    if(is.na(price)){price=0}
    data[i] = price
  }
  return (data)
}


#Scrape the most popular players
url2 <- "https://www.futbin.com/popular"
popular <- url2 %>%
  html() %>%
  html_nodes(xpath='
             /html/body/div[7]/div[4]/ul') 
#%>%
# html_text()


hh <- htmlParse(popular,asText=T,encoding='UTF-8')

#use xpath to extract data
#TODO: weird symbols in name -> fix this asap
names <- xpathSApply(hh,'//*[@id="Player-card"]/div[3]',xmlValue)
pictures <- xpathSApply(hh, '//*[@id="player_pic"]',xmlGetAttr,'src')
ratings <- xpathSApply(hh,'//*[@id="Player-card"]/div[2]',xmlValue)
countrypics <- xpathSApply(hh,'//*[@id="player_nation"]',xmlGetAttr,'src')
clubpics <- xpathSApply(hh,'//*[@id="player_club"]',xmlGetAttr,'src')
positions <- xpathSApply(hh,'//*[@id="Player-card"]/div[4]',xmlValue)


ps_prices <- xpathSApply(hh,'//*[@class="ps_main_price"]',xmlValue)
xbox_prices <- xpathSApply(hh,'//*[@class="xbox_main_price"]',xmlValue)
ps_prices <- gsub("PS: ","",ps_prices)
xbox_prices <- gsub("XB: ","",xbox_prices)
#K x 100 and M x 1000
ps_prices = handlePrices(ps_prices)
xbox_prices = handlePrices(xbox_prices)
prices <- (as.numeric(ps_prices) + as.numeric(xbox_prices))/2


#TODO: maybe an extra column with the explicit rank? 
#merge everything into 1 dataframe
popularPlayers <- data.frame("name" = names,
                             "rating" = ratings,
                             "picture" = pictures,
                             "country" = countrypics,
                             "club" = clubpics,
                             "position" = positions,
                             "price" = prices)

popularity <- data.frame("name" = popularPlayers$name,
                         "rating"=popularPlayers$rating,
                         "position" = popularPlayers$position,
                         "price" = popularPlayers$price)
