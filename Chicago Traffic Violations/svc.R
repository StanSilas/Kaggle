#Chicago Speeding :
library(readr)
cameras <- read_csv("C:/Users/vivek/Downloads/speed-violations/cameras.csv", 
                      +     col_types = cols(DATE = col_date(format = "%m/%d/%Y")))

View(cameras)
library(leaflet)
library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)
cData<-cameras

cData %>%separate(col = DATE, into = c("Year", "Month", "Day"), convert = TRUE) ->cData

View(cData)
cData<-na.omit(cData)

# Violation counts by month , for 2014

viols<-function(x){
cData %>%
  filter(Year== x)  %>%
  select(Month,VIOLATIONS,LONGITUDE,LATITUDE)%>%
  group_by(Month) %>% 
  summarise(`Total violations` = sum(VIOLATIONS)) ->cData2
  View(cData2)

  qplot(Month, `Total violations`, data=cData2, main=paste("Chicago Speed violation Counts :",x),geom=c("point","smooth"))+ aes(colour = `Total violations`) + scale_color_gradient(low="blue", high="red")
  
  }

viols(2014)
viols(2015)
viols(2016)

#Violations by location
cDatac<-cData
cDatac$LATITUDE<-as.character(cDatac$LATITUDE)
cDatac$LONGITUDE<-as.character(cDatac$LONGITUDE)


#highviols<-function(x){
cDatac %>%
  filter(Year== 2014)  %>%
  select(Month,`CAMERA ID`, VIOLATIONS,LONGITUDE,LATITUDE)%>%
  group_by(`CAMERA ID`,LONGITUDE,LATITUDE) %>% 
  summarise(`Total violations` = sum(VIOLATIONS))->cData3

  cData3<-arrange(cData3,desc(`Total violations`))
cData3$LONGITUDE<-as.numeric(cData3$LONGITUDE)
cData3$LATITUDE<-as.numeric(cData3$LATITUDE)
cData3$Total<-as.character(cData3$`Total violations`)
   

pal <- colorNumeric(
  palette = "Blues",
  domain = cData3$`Total violations`)
 
# for a look at highways around the cameras

leaflet(cData3) %>% addTiles('http://{s}.tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png', attribution='Map tiles by <a href="http://stamen.com">Stamen Design</a>, <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>% 
  setView( -87.623177, 41.881832, zoom = 11) %>% 
  addCircles(~LONGITUDE, ~LATITUDE, 
             popup=paste("Camera", cData3$`CAMERA ID`, "<br>",
                   "Number of violations:", cData3$`Total`, "<br>"), 
             weight = 1, radius=200, 
             color= ~pal(`Total violations`), stroke = TRUE, fillOpacity = 0.9) %>% 
  addLegend("topright", colors= "blue", labels="High Violations", title="Chicago : Speed Camera Violations")

 
pal1 <- colorNumeric(
  palette = "Blues",
  domain = cData3$`Total violations`)

# for understanding where what happens
  
leaflet(cData3) %>% addTiles('http://stamen-tiles-{s}.a.ssl.fastly.net/toner/{z}/{x}/{y}.png', attribution='Map tiles by <a href="http://stamen.com">Stamen Design</a>, <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>% 
  setView( -87.623177, 41.881832, zoom = 11) %>% 
  addCircles(~LONGITUDE, ~LATITUDE, 
             popup=paste("Camera", cData3$`CAMERA ID`, "<br>",
                         "Number of violations:", cData3$`Total`, "<br>"), 
             weight = 1, radius=400, 
             color= ~pal1(`Total violations`), stroke = TRUE, fillOpacity = 0.9) %>% 
  addLegend("topright", colors= "blue", labels="High Violations", title="Chicago : Speed Camera Violations")


# looking for a better graph 
pal2 <- colorNumeric(
  palette = "Reds",
  domain = cData3$`Total violations`)

# for understanding where what happens

leaflet(cData3) %>% addTiles('http://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png', attribution='Map tiles by <a href="http://stamen.com">Stamen Design</a>, <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>') %>% 
  setView( -87.623177, 41.881832, zoom = 11) %>% 
  addCircles(~LONGITUDE, ~LATITUDE, 
             popup=paste("Camera", cData3$`CAMERA ID`, "<br>",
                         "Number of violations:", cData3$`Total`, "<br>"), 
             weight = 10, radius=400, 
             color= ~pal2(`Total violations`), stroke = TRUE, fillOpacity = 0.9) %>% 
  addLegend("topright", colors= "red", labels="High Violations", title=paste("Chicago : Speed Camera Violations",2014))
 


highviols(2014)
highviols(2015)
highviols(2016)



