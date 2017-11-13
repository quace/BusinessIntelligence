# Load twitter authorization
  secrets <- fromJSON(file='scrapers/twitter_secrets.json.nogit')
  
  setup_twitter_oauth(secrets$api_key,
                      secrets$api_secret,
                      secrets$access_token,
                      secrets$access_token_secret)

# Grab tweets
getTweets <- function(searchString, numTweets, rt_remove, fromDate, toDate){
  
    print('Searching for tweets...')
    st <- searchTwitter(searchString, n=numTweets, lang = 'en', since = "2010-01-01", retryOnRateLimit = numTweets/2)
    tweets <- data.frame(text=sapply(st, function(x) x$getText()),
                           user=sapply(st, function(x) x$getScreenName()),
                           RT=sapply(st, function(x) x$isRetweet),
                           latitude=sapply(st, function(x) as.numeric(x$latitude[1])),
                           longitude=sapply(st, function(x) as.numeric(x$longitude[1])),
                           time=sapply(st, function(x) format(x$created, format='%F %T'))
    )
  if(rt_remove){
    print('Removing Retweets...')
    tweets <-
      tweets %>%
      filter(!RT)
  }
    
  return(tweets)
}

# Clean text data
cleanTweets <- function(tweets) {
  tweets$text <- sapply(tweets$text,function(row) iconv(row, "latin1", "ASCII", sub="")) #remove emoji's
  # Gather corpus
  textdata <- Corpus(VectorSource(tweets$text))
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
  tweets$text <- textdata
  return(tweets)
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