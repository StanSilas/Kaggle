library(readr)
library(ggplot2)
library(plyr)
library(dplyr)

bbl <- read_csv("C:/Users/vivek/Downloads/billboard-1964-2015-songs-lyrics/billboard_lyrics_1964-2015.csv")

k<-as.data.frame(bbl[,5])

bbl<-bbl[,c(1:4,6)]
class(k$Lyrics)
k$length<-1
View(k)

for(i in 1: nrow(k)){
    l <- sapply(strsplit(k[i,1], " "), length)
  k[i,2]<-l
}

bbl<-cbind.data.frame(bbl,k)

str(bbl)


bbl%>%
  select(Year,length)%>%
  group_by(Year)%>%
  summarise(value=mean(length))-> bbl_avgs


qplot(bbl_avgs$Year,bbl_avgs$value, main = "Average words per song 1965-2015", xlab = "Year", ylab = "Number of Words")+geom_line()

qplot(bbl_avgs$Year,bbl_avgs$value,geom=c("point","smooth"),main = "Average words per song 1965-2015", xlab = "Year", ylab = "Number of Words")

t<-as.data.frame(table(bbl$Year))
View(t)
# 
# d<-bbl
# d<-d[!(d$Rank==11 & d$Song=="la bamba"),]
# d<-d[!(d$Rank==84 & d$Song=="sugar hill" & d$Artist=="az"),]
# d<-d[!(d$Rank==14 & d$Song=="last friday night tgif" & d$Artist=="katy perry"),]
# d<-d[!(d$Rank==6 & d$Song=="talk dirty" & d$Artist=="jason derulo featuring 2 chainz"),]
# d<-d[!(d$Rank==87 & d$Song=="no mediocre" & d$Artist=="ti featuring iggy azalea"),]
# 
# bbl<-d

library(wordcloud)
library(tm)
library(animation)
library(stringr)



 saveGIF({

  for(i in 1965:2015)
  { 
  t<-bbl[which(bbl$Year==i),]
  clean_tw<-str_replace_all(t$Lyrics,"[^[:graph:]]", " ") 
  
  vectored_data<-Corpus(VectorSource(clean_tw))
  

  clean_tw<-tm_map(vectored_data, removePunctuation)
  clean_tw<-tm_map(clean_tw,removeWords, stopwords("english"))
  clean_tw<-tm_map(clean_tw, (tolower))
  
  # layout(matrix(c(1, 2), nrow=2), heights=c(1, 4))
  # par(mar=rep(0, 4))
  # plot.new()
  # text(x=0.5, y=0.5, paste("Year",i))
  pp<-paste("plot_",i, ".png", sep = "")
  mypath <- file.path("C:","Users","Documents","BBB",pp)
  png(pp)
  wordcloud(clean_tw, random.order=F,col=rainbow(40), max.words = 100, scale = c(5,0.2))
  dev.off()
  
  }

    
 }, interval = 0.6, movie.name = "songs_blbrd.gif", ani.width = 980, ani.height = 720)











# create animation of world cloud of 1965-2015


# bbl%>%
#   select(Year,length)%>%
#   group_by(Year)%>%
#   summarise(value=count(Year))-> bbl_nums


# bbl$Lyrics<-as.character(bbl$Lyrics)
# 
# bbl$length<-0
# 
# for(i in 1: nrow(bbl)){
#   l <- sapply(strsplit(bbl[i,5], " "), length)
#   bbl[i,7]<-l
# }
