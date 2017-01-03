## Callisia niche modeling

library(dismo)
library(fields)
library(maps)
library(rgdal)
library(raster)
library(maptools)
library(dplyr)
library(rJava)

# create subdirectories
dir.create("models")

# load and parse historical occurrence data
historical <- read.csv(file="data/callisia_historical_occurrence.csv")
histBoth <- historical %>%
  dplyr::select(Cytotype, Longitude, Latitude)
histDip <- historical %>% 
  filter(Cytotype == "2X") %>%
  dplyr::select(Longitude, Latitude)
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

# default maxent modeling
# diploid modeling
maxentDip <- maxent(predictorsHist, histDip)
maxentDip # view results in browser window
dir.create("models/diploidMaxent")
# save output files
file.copy(maxentDip@path, "models/diploidMaxent/", recursive=TRUE) 
response(maxentDip) # show response curves for each layer
predDip <- predict(maxentDip, predictorsHist) # create model
# plot predictive model
plot(predDip) 
points(histDip)
writeRaster(predDip, "models/diploidMaxent/histDip.grd")

# default maxent modeling
# tetraploid modeling
maxentTet <- maxent(predictorsHist, histTet)
maxentTet # view results in browser window
dir.create("models/tetraploidMaxent")
# save output files
file.copy(maxentTet@path, "models/tetraploidMaxent/", recursive=TRUE)  
response(maxentTet) # show response curves for each layer
predTet <- predict(maxentTet, predictorsHist) # create model
# plot predictive model
plot(predTet) 
points(histTet)
writeRaster(predTet, "models/tetraploidMaxent/histTet.grd")

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
predDipContemp <- predict(maxentDip, predictorsContemp) # create model
# plot predictive model
plot(predDipContemp) 
points(histDip)
writeRaster(predDipContemp, "models/diploidMaxent/contempDip.grd")

predTetContemp <- predict(maxentTet, predictorsContemp) # create model
# plot predictive model
plot(predTetContemp)
points(histTet)
writeRaster(predTetContemp, "models/tetraploidMaxent/histTetContemp.grd")
