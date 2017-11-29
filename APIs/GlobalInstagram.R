library(instaR)

#my_app_client_id  <- "3f75b726a73043c487c791aba29f336b"
#my_app_client_secret <- "e954c0a6c3f04903a5653e6437c70e82"

#my_app_OAuth <- instaOAuth(my_app_client_id, my_app_client_secret, scope = "basic")
#save(my_app_OAuth, file="my_app_OAuth")
load("my_app_OAuth")

my_access_token <- my_app_OAuth$credentials$access_token
