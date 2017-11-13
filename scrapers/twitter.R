library(Rcrawler)
getURLS <- function() {
  URLS <- c()
  for(i in 1:6) {
    URLS[i] <- paste(c("http://fanpagelist.com/category/athletes/soccer/view/list/sort/lists/page", i), collapse = "") 
  }
  return(URLS)
}
Reviews<-ContentScraper(Url = URLS(), CssPatterns =c(".entry-title","#comments p"), ManyPerPattern = TRUE)