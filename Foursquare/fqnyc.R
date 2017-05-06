#NYC foursquare checkins

library(plyr)
library(dplyr)
library(ggplot2)
library(readr)
fsnyc <- read_csv("S:/Kaggle/Foursquare checkins/dataset_TSMC2014_NYC.csv")
View(fsnyc)


View(table(fsnyc$venueCategory))
View(table(fsnyc$longitude))
View(table(fsnyc$venueId))
View(table(fsnyc$userId))

#by usr-location
fsnyc%>%
  select(userId,longitude,latitude)%>%
  group_by(userId)->fsnyc_by_usr
#by venue-location
#fsnyc$venueCategory<-as.factor(fsnyc$venueCategory)

fsnyc%>%
  select(venueCategory,longitude,latitude)%>%
  group_by(venueCategory)%>%
  summarise(value=count(venueCategory))->fsnyc_by_loc

View(fsnyc_by_cat)
# fsnyc %>%
#   separate(col = utcTimestamp, into = c("Year", "Month", "Day"), convert = TRUE) ->Mis_Data
t<-as.data.frame(table(fsnyc$venueCategory))

View(t)

t<- t[order(-(t$Freq)),] 



