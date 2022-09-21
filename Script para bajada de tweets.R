
install.packages("academictwitteR")
library(academictwitteR)
library(readr)
library(tidyverse)
set_bearer()


query_search <- "trigo transgenico"
search_from <- "2010-01-01T00:00:00Z" #AAAA-MM-DD-THH:MM:SSZ
search_to <- "2022-01-01T00:00:00Z" #AAAA-MM-DD-THH:MM:SSZ
qty <- 100000
env <- "research"


tweets_df <- get_all_tweets(
  query = query_search,
  start_tweets = search_from,
  end_tweets = search_to,
  n = qty,
  data_path = env,
  is_retweet = FALSE,
  lang= "es"
)

search_from_new <- substr(search_from, 1, 10)
search_to_new <- substr(search_to, 1, 10)

file_name <- paste("C:/Datasets/", query_search, "_", search_from_new,"_", search_to_new,".csv", sep="")


tweets_df_clean <- tweets_df
tweets_df_clean <- cbind(tweets_df_clean[,c("text", "id", "author_id", "lang",
                                            "in_reply_to_user_id", 
                                            "referenced_tweets", "source",
                                            "conversation_id", "created_at", 
                                            "possibly_sensitive")],
                         tweets_df_clean[,c("public_metrics")],
                         tweets_df_clean[,c("entities")], 
                         tweets_df_clean[,c("geo")], 
                         tweets_df_clean[,c("attachments")])


write.csv2(tweets_df_clean, file = file_name,
           row.names = FALSE, fileEncoding = "UTF-8")