library(sf)
library(cartography)
library(leaflet)
library(htmltools)
library(htmlwidgets)


# TITLE & SOURCES

title <- tags$div(includeCSS("css/maptitle.css"), HTML("<i>1,5 MILLIONS DE MANIFESTANT.E.S LE 5 DÉCEMBRE CONTRE LA RÉFORME DES RETRAITES</i>"))  
source <- tags$div(includeCSS("css/mapnote.css"), HTML(paste0("Cartographie : <b>Nicolas LAMBERT, 2019</b> - ","Sources : https://mobilisations-en-france.cgt.fr/news/map & contributions facebook & twitter")))
contrib <- tags$div(includeCSS("css/contrib.css"), HTML("<a href='form.html'>[Ajoutez des données]</a>"))  


# DATA

manif <- read.csv("data/manif.csv", stringsAsFactors = F)



# CIRCLE SIZES

var <- "nb5dec"
k <- 0.07
manif$size <- sqrt(manif[,var]*k / pi)
manif <- manif[order(manif$size, decreasing = TRUE), ]

# LABEL

manif$labelhtml <- paste0(
  "<div width='300px' align='center'>",
  "<h2>",manif$Ville,
  "</h2>",
  "<b>",manif$nb5dec," manifestant.e.s</b>",
  "</div>"
)

# LEAFLET MAP

m <- leaflet(manif) %>%
  addProviderTiles(providers$Stamen.TonerBackground) %>%
  setView(lng = 3.5, lat = 46.5, zoom = 07) %>%
  addScaleBar(position = "bottomleft") %>%
  addControl(title, className="map-title") %>%
  addControl(source, className="map-note")  %>%
 addControl(contrib, className="map-contrib")

m <- addCircleMarkers(map = m, 
                      lng = manif$longitude, 
                      lat = manif$latitude, 
                      radius = manif$size, weight = 1, 
                      stroke = T, opacity = 100,
                      fill = T, fillColor = "#e4072f", 
                      fillOpacity = 100,
                      popup = manif$labelhtml,
                      color = "white")
m

saveWidget(m, file="index.html", title = "Tous ensemble jusqu'au retrait !", selfcontained = TRUE)
