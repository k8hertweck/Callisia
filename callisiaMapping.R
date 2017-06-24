## Callisia mapping and data preparation

## load libraries
library(dismo)
library(fields)
library(maps)
library(rgdal)
library(raster)
library(maptools)
library(dplyr)
library(ggplot2)
library(stringr)

# create directory for figures
dir.create("figures")

## load and parse historical data
historical <- read.csv(file="data/callisia_historical_occurrence.csv")
histDip <- historical %>% 
  filter(Cytotype == "2X")
histTet <- historical %>%
  filter(Cytotype == "4X")

# load and parse contemporary data
contemp <- read.csv(file="data/callisia_contemporary_occurrence.csv")
# basic histogram
hist(contemp$pg.2C)
contempGS <- contemp %>%
  filter(pg.2C != "NA")
# ggplot histogram
ggplot(contempGS, aes(pg.2C)) + geom_histogram(binwidth=5) + 
  labs(x = "genome size (pg/2C)",
       y = "number of individuals") +
  theme_bw() +
  theme(axis.title = element_text(size=22)) +
  theme(axis.text = element_text(size=20))
ggsave("figures/GShistogram.jpg", width=10, height=8)
# plot histogram and color by site
ggplot(contempGS, aes(pg.2C, fill=Site.number), color=Site.number) + geom_histogram(binwidth=5)
# separate into putative diploid and tetraploid
contempDip <- contempGS %>%
  filter(pg.2C < 60)
range(contempDip$pg.2C) #36.53 47.87
write.csv(contempDip, "data/contemporaryDiploid.csv", row.names=FALSE)
contempTet <- contempGS %>%
  filter(pg.2C > 60)
range(contempTet$pg.2C) #73.71 84.52
write.csv(contempTet, "data/contemporaryTetraploid.csv", row.names = FALSE)

# map all occurrence points
jpeg(file="figures/mappingAll.jpg")
southeast <- c("florida", "georgia", "north carolina", "south carolina")
map(database="state", regions = southeast, interior=T, lwd=2)
points(histDip$Longitude, histDip$Latitude, col='#a6cee3', pch=20, cex=2)
points(histTet$Longitude, histTet$Latitude, col='#b2df8a', pch=20, cex=2)
points(contempDip$Longitude, contempDip$Latitude, col='#1f78b4', pch=20, cex=2)
points(contempTet$Longitude, contempTet$Latitude, col='#33a02c', pch=20, cex=2)
dev.off()

# map only NC and SC
histTetCar <- histTet %>%
  filter(!str_detect(Locality, "Fla")) %>% 
  filter(!str_detect(Locality, "GA"))
NCSC <- c("north carolina", "south carolina")
jpeg("figures/mappingCar.jpg")
map(database="state", regions = NCSC, interior=T, lwd=2)
points(histDip$Longitude, histDip$Latitude, col='#a6cee3', pch=20, cex=3)
points(histTetCar$Longitude, histTetCar$Latitude, col='#b2df8a', pch=20, cex=3)
points(contempDip$Longitude, contempDip$Latitude, col='#1f78b4', pch=20, cex=3)
points(contempTet$Longitude, contempTet$Latitude, col='#33a02c', pch=20, cex=3)
dev.off()

# map plain use outline
jpeg("figures/us.jpg")
map(database="state")
dev.off()
