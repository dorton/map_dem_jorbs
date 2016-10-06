# be sure to set your working directory properly! see the next line.
setwd("~/githubprojects/mapjorbs")
raw <- read.csv(file="map_dem_jorbs.csv", header=T)
library(ggmap)
address <- geocode(as.character(raw$Address))
raw$lat <- address$lat
raw$lon <- address$lon
library(magrittr)
library(leaflet)
tiyicon <- makeIcon(
  iconUrl = "https://www.theironyard.com/assets/iron-yard-logo-709fbbf7ff0d1d76e83b9a782b79e7c4edb840974a7b3d9dd4f33b8cf5b87571.svg",
  iconWidth = 28, iconHeight = 85,
)
ironyard <- leaflet() %>% 
  addTiles() %>% 
  addProviderTiles("Esri.NatGeoWorldMap") %>%
  setView(-95.37, 29.75, zoom = 5) %>% 
  addMarkers(data = raw, lng = ~ lon, lat = ~ lat, icon = tiyicon, popup = paste("Company: ",raw$Company,"<br/>Position: ",raw$Position, "<br/>Class: ",raw$Class), clusterOptions=markerClusterOptions())
ironyard
