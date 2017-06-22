## Callisia niche modeling

library(dismo)
library(fields)
library(maps)
library(rgdal)
library(raster)
library(maptools)
library(dplyr)
library(rJava)
library(viridis)

# create subdirectories
dir.create("models")
# model nomenclature: 
# hist=historical, contemp=contemporary
# first references points, second references layers for maxent, third is layers for projection
# folders labeled with layers for maxent

# load contemporary occurrence data
contempDip <- read.csv(file="data/contemporaryDiploid.csv")
contempDip <- dplyr::select(contempDip, Longitude, Latitude)
contempTet <- read.csv(file="data/contemporaryTetraploid.csv")
contempTet <- dplyr::select(contempTet, Longitude, Latitude)

# load and parse historical occurrence data
historical <- read.csv(file="data/callisia_historical_occurrence.csv")
histBoth <- historical %>%
  dplyr::select(Cytotype, Longitude, Latitude)
histDip <- historical %>% 
  filter(Cytotype == "2X") %>%
  dplyr::select(Longitude, Latitude)
write.csv(histDip, "data/historicalDiploid.csv", row.names = FALSE)
histTet <- historical %>%
  filter(Cytotype == "4X") %>%
  dplyr::select(Longitude, Latitude)
# find occurrence points outside shapefile borders
CRS <- "+proj=longlat +datum=NAD83 +ellps=GRS80 +towgs84=0,0,0 +no_defs"
SEstates <- readShapePoly("shapefiles/SEstates", proj4string = CRS(CRS))
tetTemp <- histTet
coordinates(tetTemp) <- ~Longitude+Latitude # assign coordinates
crs(tetTemp) <- crs(SEstates) # apply CRS
overTet <- over(tetTemp, SEstates) # query polygons
rmTet <- which(is.na(overTet$NAME)) # find outliers
histTet <- histTet[-rmTet,] # remove outliers
write.csv(histTet, "data/historicalTetraploid.csv", row.names = FALSE)

## load historical layers
ppt <- raster("PastLayers/ppt.asc", crs=CRS)
tdmean <- raster("PastLayers/tdmean.asc", crs=CRS)
tmax <- raster("PastLayers/tmax.asc", crs=CRS)
tmean <- raster("PastLayers/tmean.asc", crs=CRS)
tmin <- raster("PastLayers/tmin.asc", crs=CRS)
vpdmax <- raster("PastLayers/vpdmax.asc", crs=CRS)
vpdmin <- raster("PastLayers/vpdmin.asc", crs=CRS)

## stack uncorrelated historical layers (0.75): ppt, tmean, vpdmax, vpdmin
predictorsHist <- stack(ppt, tmean, vpdmax, vpdmin)
# plot each layer individually
plot(predictorsHist)

# default maxent modeling (historical points, historical layers)
# diploid modeling
maxentHistHistDip <- maxent(predictorsHist, histDip)
maxentHistHistDip # view results in browser window
dir.create("models/diploidHistMaxent")
# save output files
file.copy(maxentHistHistDip@path, "models/diploidHistMaxent/", recursive=TRUE)
response(maxentHistHistDip) # show response curves for each layer
predHistHistHistDip <- predict(maxentHistHistDip, predictorsHist) # create model
# plot predictive model
plot(predHistHistHistDip) 
points(histDip)
writeRaster(predHistHistHistDip, "models/diploidHistMaxent/histHistHistDip.grd")

# tetraploid modeling (historical points, historical layers)
maxentHistHistTet <- maxent(predictorsHist, histTet)
maxentHistHistTet # view results in browser window
dir.create("models/tetraploidHistMaxent")
# save output files
file.copy(maxentTet@path, "models/tetraploidHistMaxent/", recursive=TRUE)  
response(maxentHistHistTet) # show response curves for each layer
predHistHistHistTet <- predict(maxentHistHistTet, predictorsHist) # create model
# plot predictive model
plot(predHistHistHistTet) 
points(histTet)
writeRaster(predHistHistHistTet, "models/tetraploidHistMaxent/histHistHistTet.grd")

## load contemporary layers
ppt15 <- raster("PresentLayers/ppt.asc", crs=CRS)
tdmean15 <- raster("PresentLayers/tdmean.asc", crs=CRS)
tmax15 <- raster("PresentLayers/tmax.asc", crs=CRS)
tmean15 <- raster("PresentLayers/tmean.asc", crs=CRS)
tmin15 <- raster("PresentLayers/tmin.asc", crs=CRS)
vpdmax15 <- raster("PresentLayers/vpdmax.asc", crs=CRS)
vpdmin15 <- raster("PresentLayers/vpdmin.asc", crs=CRS)

## stack uncorrelated contemporary layers (0.75): ppt, tmean, vpdmax, vpdmin
predictorsContemp <- stack(ppt15, tmean15, vpdmax15, vpdmin15)
# plot each layer individually
plot(predictorsContemp)

# project historical model onto contemporary layers
predHistHistContempDip <- predict(maxentHistHistDip, predictorsContemp) # create model
# plot predictive model
plot(predHistHistContempDip) 
points(histDip)
writeRaster(predHistHistContempDip, "models/diploidHistMaxent/histHistContempDip.grd")

predHistHistContempTet <- predict(maxentHistHistTet, predictorsContemp) # create model
# plot predictive model
plot(predHistHistContempTet)
points(histTet)
writeRaster(predHistHistContempTet, "models/tetraploidHistMaxent/histHistContempTet.grd")

# default maxent modeling (historical points, contemporary layers)
# diploid modeling
maxentHistContempDip <- maxent(predictorsContemp, histDip)
maxentHistContempDip # view results in browser window
dir.create("models/diploidContempMaxent")
# save output files
file.copy(maxentHistContempDip@path, "models/diploidContempMaxent/", recursive=TRUE) 
response(maxentHistContempDip) # show response curves for each layer
predHistContempContempDip <- predict(maxentHistContempDip, predictorsContemp) # create model
# plot predictive model
plot(predHistContempContempDip) 
points(histDip)
writeRaster(predHistContempContempDip, "models/diploidContempMaxent/histContempContempDip.grd")

# tetraploid modeling (historical points, contemporary layers)
maxentHistContempTet <- maxent(predictorsContemp, histTet)
maxentHistContempTet # view results in browser window
dir.create("models/tetraploidContempMaxent")
# save output files
file.copy(maxentHistContempTet@path, "models/tetraploidContempMaxent/", recursive=TRUE)  
response(maxentHistContempTet) # show response curves for each layer
predHistContempContempTet <- predict(maxentHistContempTet, predictorsContemp) # create model
# plot predictive model
plot(predHistContempContempTet) 
points(histTet)
writeRaster(predHistContempContempTet, "models/tetraploidContempMaxent/histContempContempTet.grd")

# default maxent modeling (contemporary points, contemporary layers)
# diploid modeling
maxentContempContempDip <- maxent(predictorsContemp, contempDip)
maxentContempContempDip # view results in browser window
dir.create("models/diploidModMaxent")
# save output files
file.copy(maxentContempContempDip@path, "models/diploidModMaxent/", recursive=TRUE) 
response(maxentContempContempDip) # show response curves for each layer
predContempContempContempDip <- predict(maxentContempContempDip, predictorsContemp) # create model
# plot predictive model
plot(predContempContempContempDip) 
points(contempDip)
writeRaster(predContempContempContempDip, "models/diploidModMaxent/contempContempContempDip.grd")

# tetraploid modeling (contemporary points, contemporary layers)
maxentContempContempTet <- maxent(predictorsContemp, contempTet)
maxentContempContempTet # view results in browser window
dir.create("models/tetraploidModMaxent")
# save output files
file.copy(maxentContempContempTet@path, "models/tetraploidModMaxent/", recursive=TRUE)  
response(maxentContempContempTet) # show response curves for each layer
predContempContempContempTet <- predict(maxentContempContempTet, predictorsContemp) # create model
# plot predictive model
plot(predContempContempContempTet) 
points(contempTet)
writeRaster(predContempContempContempTet, "models/tetraploidModMaxent/contempContempContempTet.grd")

## create plots for figures
# load projections
predHistHistHistDip <- raster("models/diploidHistMaxent/histHistHistDip.grd")
predHistHistHistTet <- raster("models/tetraploidHistMaxent/histHistHistTet.grd")
predHistHistContempDip <- raster("models/diploidHistMaxent/histHistContempDip.grd")
predHistHistContempTet <- raster("models/tetraploidHistMaxent/histHistContempTet.grd")
predHistContempContempDip <- raster("models/diploidContempMaxent/histContempContempDip.grd")
predHistContempContempTet <- raster("models/tetraploidContempMaxent/histContempContempTet.grd")
predContempContempContempDip <- raster("models/diploidModMaxent/contempContempContempDip.grd")
predContempContempContempTet <- raster("models/tetraploidModMaxent/contempContempContempTet.grd")

# plot prep
#colors <- brewer.pal(8, "YlGnBu")
brk <- c(0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1)

# quick plots, individual
jpeg("figures/histHistHistDip.jpg")
plot(predHistHistHistDip, legend=FALSE, col=magma(10), axes=FALSE, breaks=brk)
dev.off()
jpeg("figures/histHistHistTet.jpg")
plot(predHistHistHistTet, legend=FALSE, col=magma(10), axes=FALSE, breaks=brk)
dev.off()
jpeg("figures/histHistContempDip.jpg")
plot(predHistHistContempDip, legend=FALSE, col=magma(10), axes=FALSE, breaks=brk)
dev.off()
jpeg("figures/histHistContempTet.jpg")
plot(predHistHistContempTet, legend=FALSE, col=magma(10), axes=FALSE, breaks=brk)
dev.off()
jpeg("figures/histContempContempDip.jpg")
plot(predHistContempContempDip, legend=FALSE, col=magma(10), axes=FALSE, breaks=brk)
dev.off()
jpeg("figures/histContempContempTet.jpg")
plot(predHistContempContempTet, legend=FALSE, col=magma(10), axes=FALSE, breaks=brk)
dev.off()
jpeg("figures/contempContempContempDip.jpg")
plot(predContempContempContempDip, legend=FALSE, col=magma(10), axes=FALSE, breaks=brk)
dev.off()
jpeg("figures/contempContempContempTet.jpg")
plot(predContempContempContempTet, legend=FALSE, col=magma(10), axes=FALSE, breaks=brk)
dev.off()

# create plot for sharing
jpeg("figures/projections.jpg")
par(mfrow=c(2,2), mar=c(2,2,2,2), bty="n")
plot(predHistHistHistDip, legend=FALSE, col=magma(10), axes=FALSE, breaks=brk)
points(histDip$Longitude, histDip$Latitude, pch=20, cex=0.8, col="white")
mtext("diploid", cex=1.5)
mtext("1930", side=2, cex=1.5, las=3)

plot(predHistHistHistTet, legend=FALSE, col=magma(10), axes=FALSE, breaks=brk)
points(histTet$Longitude, histTet$Latitude, pch=20, cex=0.8, col="white")
mtext("tetraploid", cex=1.5)

plot(predHistHistContempDip, legend=FALSE, col=magma(10), axes=FALSE, breaks=brk)
points(contempDip$Longitude, contempDip$Latitude, pch=20, cex=0.8, col="white")
mtext("2015", side=2, cex=1.5, las=3)

plot(predHistHistContempTet, legend=FALSE, col=magma(10), axes=FALSE, breaks=brk)
points(contempTet$Longitude, contempTet$Latitude, pch=20, cex=0.8, col="white")
dev.off()

