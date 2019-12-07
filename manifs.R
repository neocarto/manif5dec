library(sf)
library(cartography)


# METADATA

source <- "https://mobilisations-en-france.cgt.fr/news/map & contributions facebbok & twitter"
author <- "Nicolas Lambert, 2019"


# DATA
dpt <- st_read("data/depts.shp")
other <- st_read("data/others.shp")
manif <- read.csv("data/manif.csv", stringsAsFactors = F)
manif <- st_as_sf(manif, coords = c("longitude", "latitude"), crs = 4326)
manif <- st_transform(manif,crs = st_crs(dpt))

plot(st_geometry(other), col="#CCCCCC", border = NA)
plot(st_geometry(dpt), col="#DDDDDD", border = NA, add=T)
propSymbolsLayer(manif,var = "nb5dec",inches = 0.4,fixmax = 100000)
