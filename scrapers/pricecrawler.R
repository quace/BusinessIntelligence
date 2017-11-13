
#Rcrawler(Website = "https://www.futbin.com/18/players", no_cores = 4, no_conn = 4, XpathPatterns = c("//*[@id='Player-card']/div[2]","//*[@id='player_pic']","//*[@id='info_content']/table/tbody/tr[2]/td/a","//*[@id='info_content']/table/tbody/tr[3]/td/a"), PatternsNames = c("Name","Image","Club","Country"), MaxDepth=1, urlregexfilter = "/players")

Rcrawler(Website = "https://www.futbin.com/18/players", no_cores = 4, no_conn = 4, ExtractXpathPat = c("//*[@id='Player-card']/div[2]","//*[@id='player_pic']","//*[@id='info_content']/table/tbody/tr[2]/td/a","//*[@id='info_content']/table/tbody/tr[3]/td/a"), PatternsNames = c("Name","Image","Club","Country"), MaxDepth = 1)

#Rcrawler(Website="http://101greatgoals.com/betting/" ,MaxDepth=4, urlregexfilter = "/betting/")