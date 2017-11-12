# Global setups

library(twitteR)
library(tm)
library(rjson)
library(wordcloud)
library(dplyr)
library(caret)
library(ggplot2)
library(RColorBrewer)
library(stringr)
library(syuzhet) # for sentiment analysis
library(scales)
library(rbokeh)
library(base64enc) # fix for twitter oauth in shinyapps.io
library(SnowballC) # fix for stemming issue in tm

# Load twitter authorization
if(runOnline){
  secrets <- fromJSON(file='scrapers/twitter_secrets.json.nogit')
  
  setup_twitter_oauth(secrets$api_key,
                      secrets$api_secret,
                      secrets$access_token,
                      secrets$access_token_secret)
}

# Grab tweets
getTweets <- function(searchString, numTweets, rt_remove, fromDate, toDate){
  
    print('Searching for tweets...')
    st <- searchTwitter(searchString, n=numTweets, lang = 'en')
    statuses <- data.frame(text=sapply(st, function(x) x$getText()),
                           user=sapply(st, function(x) x$getScreenName()),
                           RT=sapply(st, function(x) x$isRetweet),
                           latitude=sapply(st, function(x) as.numeric(x$latitude[1])),
                           longitude=sapply(st, function(x) as.numeric(x$longitude[1])),
                           time=sapply(st, function(x) format(x$created, format='%F %T'))
    )
  if(rt_remove){
    print('Removing Retweets...')
    statuses <-
      statuses %>%
      filter(!RT)
  }
  return(statuses)
}

# Grab text data
getTextData <- function(statuses) {
  # Gather corpus
  textdata <- Corpus(VectorSource(statuses$text))
  textdata <- 
    textdata %>%
    tm_map(removeWords, stopwords("english")) %>%
    tm_map(removePunctuation) %>%
    tm_map(content_transformer(function(x) iconv(x, from='ASCII', 
                                                 to='UTF-8', sub='byte'))) %>%
    tm_map(content_transformer(tolower)) %>%
    tm_map(content_transformer(function(x) str_replace_all(x, "@\\w+", ""))) %>% # remove twitter handles
    tm_map(removeNumbers) %>%
    tm_map(stemDocument) %>%
    tm_map(stripWhitespace)
}

# Get sentiment data
getSentiments <- function(textdata){
  sentiments <- sapply(textdata, function(x) get_nrc_sentiment(as.character(x)))
  
  sentiments <- as.data.frame(aperm(sentiments)) # transpose and save as dataframe
  sentiments <- as.data.frame(lapply(sentiments, as.numeric)) # a bit more to organize
  sentiments <-
    sentiments %>%
    mutate(positivity = positive - negative)
}

# Do the PCA analysis
doPCA <- function(textdata, statuses, sentiments){
  dtm <- DocumentTermMatrix(textdata)
  dtm <- as.matrix(dtm) #inspect(dtm)
  
  words <- data.frame(term = colnames(dtm))
  words$count <- colSums(dtm)
  
  words <-
    words %>%
    mutate(freq = count/nrow(statuses)) %>%
    arrange(desc(count))
  
  tweets <- as.data.frame(dtm)
  ind <- data.frame('id'=seq.int(nrow(tweets)))
  tweets <- cbind(ind, tweets)
  
  # Eliminate very common terms (like the search term)
  numToCut <- max(1, sum(words$freq>0.9))
  words_100 <- as.character(words[1+numToCut:100+numToCut,'term'])
  tweets <- tweets[,c('id',words_100)]
  
  trans <- preProcess(tweets[,2:ncol(tweets)], method=c("pca"), thresh = 0.95)
  pca <- predict(trans, tweets[,2:ncol(tweets)])
  statuses <- cbind(statuses, pca[,1:5], sentiments)
  
  return(list("statuses"=statuses, "pca"=trans))
}