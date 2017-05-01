library(readr)
library(plyr)
library(dplyr)
library(ggplot2)
library(ggmap)
#' 
#' D. Kahle and H. Wickham. ggmap: Spatial Visualization with
#' ggplot2. The R Journal, 5(1), 144-161. URL
#' http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf
#' 
#' A BibTeX entry for LaTeX users is
#' 
#' Article{,
#'   author = {David Kahle and Hadley Wickham},
#'   title = {ggmap: Spatial Visualization with ggplot2},
#'   journal = {The R Journal},
#'   year = {2013},
#'   volume = {5},
#'   number = {1},
#'   pages = {144--161},
#'   url = {http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf},
#' }

fed_cs <- read_csv("C:/Users/vivek/Downloads/fed_campsites.csv")
View(fed_cs)

str(fed_cs)
summary(fed_cs)


# creating a sample data.frame with your lat/lon points

df <- fed_cs

# getting the map

mapgilbert <- get_map(location = c(lon = -95, lat = 30), zoom = 3,
                      maptype = "satellite", scale = 2)



# 
# , "terrain-background", "satellite",
# "roadmap", "hybrid", "toner", "watercolor", "terrain-labels", "terrain-lines",
# "toner-2010", "toner-2011", "toner-background", "toner-hybrid",
# "toner-labels", "toner-lines", "toner-lite"



# plotting the map with some points on it
ggmap(mapgilbert) +
  geom_point(data = df, aes(x = df$FacilityLongitude, y = df$FacilityLatitude, fill = "red", alpha = 0.5), size = 3, shape = 21) +
  guides(fill=FALSE, alpha=FALSE, size=FALSE)



#Alternative
library(rworldmap)
library(rworldxtra)
newmap <- getMap(resolution = "high")
plot(newmap, xlim = c(-125, 20), ylim = c(20, 90), asp = 1)

points(df$FacilityLongitude, df$FacilityLatitude, col = "purple", cex = .4)


plot(newmap, xlim = c(-145, 20), ylim = c(20, 100), asp = 1)

points(df$FacilityLongitude, df$FacilityLatitude, col = "purple", cex = .4)
