#Check if required packages are installed
if(!require('rvest')) {install.packages('rvest') }
if(!require('dplyr')) {install.packages('dplyr') }
#load required packages
library('rvest')
library('dplyr')
#web scrapping for Arnie
a1<-read_html('https://www.imdb.com/filmosearch?explore=title_type&role=nm0000216&ref_=filmo_ref_typ&sort=user_rating,desc&mode=advanced&page=1&title_type=movie')
a2<-read_html('https://www.imdb.com/filmosearch?explore=title_type&role=nm0000216&ref_=filmo_ref_typ&sort=user_rating,desc&mode=advanced&page=2&title_type=movie')
name  <- html_text(html_nodes(a1,'.lister-item-header a'))
rank  <- html_text(html_nodes(a1,'strong'))[16:65]
name1 <- html_text(html_nodes(a2,'.lister-item-header a'))[1:30]
rank1 <- html_text(html_nodes(a2,'strong'))[16:45]
#write Arnie's movies and ratings
name  <- c(name,name1)
rank  <- as.integer(c(rank,rank1))
#remove common movies
idx   <- grep("Οι αναλώσιμοι",name)
name  <- name[-idx]
rank  <- rank[-idx]
#write in a data.frame
data  <- cbind.data.frame(Actor = rep("Arnold Schwarzenegger",length(name)),
               title = name,rank=rank,
               stringsAsFactors = F)
#web scrapping for Sly
a1<-read_html('https://www.imdb.com/filmosearch?explore=title_type&role=nm0000230&ref_=filmo_ref_typ&sort=user_rating,desc&mode=detail&page=1&title_type=movie')
a2<-read_html('https://www.imdb.com/filmosearch?explore=title_type&role=nm0000230&ref_=filmo_nxt&sort=user_rating,desc&mode=detail&page=2&title_type=movie')
name  <- html_text(html_nodes(a1,'.lister-item-header a'))
rank  <- html_text(html_nodes(a1,'strong'))[16:65]
name1 <- html_text(html_nodes(a2,'.lister-item-header a'))[1:28]
rank1 <- html_text(html_nodes(a2,'strong'))[16:43]
#write Arnie's movies and ratings
name  <- c(name,name1)
rank  <- as.integer(c(rank,rank1))
#remove common movies
idx   <- grep("Οι αναλώσιμοι",name)
name  <- name[-idx]
rank  <- rank[-idx]
#bind 
data1 <- cbind.data.frame(Actor=rep("Sylvester Stallone",length(name)),
                  title = name,rank=rank,
                  stringsAsFactors = F)
#bind data
data <- bind_rows(list(data,data1))
#write the data to a csv file
write.csv(data,'data.csv',row.names = F)
#delete all
rm(list = ls())
#and now the database is ready!