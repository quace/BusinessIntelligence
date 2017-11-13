library(Rcrawler)
getURLS <- function() {
  URLS <- c()
  for(i in 1:6) {
    URLS[i] <- paste(c("http://fanpagelist.com/category/athletes/soccer/view/list/sort/lists/page", i), collapse = "") 
  }
  return(URLS)
}
Reviews<-ContentScraper(Url = getURLS(), XpathPatterns =c("//*/div[@id='rank_number']//span[@class='symbol']"), ManyPerPattern = TRUE)