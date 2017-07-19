## Preparing layers for niche modeling

library(dismo)
library(fields)
library(maps)
library(rgdal)
library(raster)
library(maptools)
library(rJava)

# create subdirectories
dir.create("shapefiles")
dir.create("PastLayers")
dir.create("PresentLayers")

# prepare shapefiles
download.file("http://www2.census.gov/geo/tiger/GENZ2015/shp/cb_2015_us_state_20m.zip", "cb_2015_us_state_20m.zip")
unzip("cb_2015_us_state_20m.zip", exdir="shapefiles")
system("rm cb_2015_us_state_20m.zip")
# load shapefiles and set projection
state <- readShapePoly("shapefiles/cb_2015_us_state_20m.shp") 
projection(state) <- CRS("+proj=longlat +datum=NAD83 +ellps=GRS80 +towgs84=0,0,0 +no_defs")
# extract shapefiles of interest and save to file 
southeastStatesCap <- c("Florida", "Georgia", "North Carolina", "South Carolina")
SEstates <- state[as.character(state@data$NAME) %in% southeastStatesCap, ]
writeSpatialShape(SEstates, "shapefiles/SEstates")

# PRISM downloaded from http://www.prism.oregonstate.edu/historical/ in .bil format for precipitation, mean temperature, minimum temperature, maximum temperature, mean dewpoint temperature, minimum vapor pressure deficit, maximum vapor pressure deficit

## load historical PRISM layers from 1940
ppt <- raster("~/data/PRISM/PRISM_ppt_stable_4kmM2_1940_all_bil/PRISM_ppt_stable_4kmM2_1940_bil.bil")
tdmean <- raster("~/data/PRISM/PRISM_tdmean_stable_4kmM1_1940_all_bil/PRISM_tdmean_stable_4kmM1_1940_bil.bil")
tmax <- raster("~/data/PRISM/PRISM_tmax_stable_4kmM2_1940_all_bil/PRISM_tmax_stable_4kmM2_1940_bil.bil")
tmean <- raster("~/data/PRISM/PRISM_tmean_stable_4kmM2_1940_all_bil/PRISM_tmean_stable_4kmM2_1940_bil.bil")
tmin <- raster("~/data/PRISM/PRISM_tmin_stable_4kmM2_1940_all_bil/PRISM_tmin_stable_4kmM2_1940_bil.bil")
vpdmax <- raster("~/data/PRISM/PRISM_vpdmax_stable_4kmM1_1940_all_bil/PRISM_vpdmax_stable_4kmM1_1940_bil.bil")
vpdmin <- raster("~/data/PRISM/PRISM_vpdmin_stable_4kmM1_1940_all_bil/PRISM_vpdmin_stable_4kmM1_1940_bil.bil")

## clip historical data layers
ppt <- mask(ppt, SEstates)
ppt <- crop(ppt, extent(SEstates))
writeRaster(ppt, "PastLayers/ppt.asc", format="ascii", overwrite=TRUE)

tdmean <- mask(tdmean, SEstates)
tdmean <- crop(tdmean, extent(SEstates))
writeRaster(tdmean, "PastLayers/tdmean.asc", format="ascii", overwrite=TRUE)

tmax <- mask(tmax, SEstates)
tmax <- crop(tmax, extent(SEstates))
writeRaster(tmax, "PastLayers/tmax.asc", format="ascii", overwrite=TRUE)

tmean <- mask(tmean, SEstates)
tmean <- crop(tmean, extent(SEstates))
writeRaster(tmean, "PastLayers/tmean.asc", format="ascii", overwrite=TRUE)

tmin <- mask(tmin, SEstates)
tmin <- crop(tmin, extent(SEstates))
writeRaster(tmin, "PastLayers/tmin.asc", format="ascii", overwrite=TRUE)

vpdmax <- mask(vpdmax, SEstates)
vpdmax <- crop(vpdmax, extent(SEstates))
writeRaster(vpdmax, "PastLayers/vpdmax.asc", format="ascii", overwrite=TRUE)

vpdmin <- mask(vpdmin, SEstates)
vpdmin <- crop(vpdmin, extent(SEstates))
writeRaster(vpdmin, "PastLayers/vpdmin.asc", format="ascii", overwrite=TRUE)

## load historical layers (if not already loaded)
ppt <- raster("PastLayers/ppt.asc")
tdmean <- raster("PastLayers/tdmean.asc")
tmax <- raster("PastLayers/tmax.asc")
tmean <- raster("PastLayers/tmean.asc")
tmin <- raster("PastLayers/tmin.asc")
vpdmax <- raster("PastLayers/vpdmax.asc")
vpdmin <- raster("PastLayers/vpdmin.asc")

## Correlation analysis for historical layers
stackHist <- stack(ppt, tdmean, tmax, tmean, tmin, vpdmax, vpdmin) 
corrHist <- layerStats(stackHist, 'pearson', na.rm=TRUE)
pearsonHist <- corrHist$`pearson correlation coefficient`
write.csv(pearsonHist, "PastLayers/correlationPRISM1940.csv")

## load contemporary PRISM layers from 2015
ppt15 <- raster("~/data/PRISM/PRISM_ppt_stable_4kmM3_2015_bil/PRISM_ppt_stable_4kmM3_2015_bil.bil")
tdmean15 <- raster("~/data/PRISM/PRISM_tdmean_stable_4kmM1_2015_bil/PRISM_tdmean_stable_4kmM1_2015_bil.bil")
tmax15 <- raster("~/data/PRISM/PRISM_tmax_stable_4kmM2_2015_bil/PRISM_tmax_stable_4kmM2_2015_bil.bil")
tmean15 <- raster("~/data/PRISM/PRISM_tmean_stable_4kmM2_2015_bil/PRISM_tmean_stable_4kmM2_2015_bil.bil")
tmin15 <- raster("~/data/PRISM/PRISM_tmin_stable_4kmM2_2015_bil/PRISM_tmin_stable_4kmM2_2015_bil.bil")
vpdmax15 <- raster("~/data/PRISM/PRISM_vpdmax_stable_4kmM1_2015_bil/PRISM_vpdmax_stable_4kmM1_2015_bil.bil")
vpdmin15 <- raster("~/data/PRISM/PRISM_vpdmin_stable_4kmM1_2015_bil/PRISM_vpdmin_stable_4kmM1_2015_bil.bil")

## clip contemporary data layers
ppt15 <- mask(ppt15, SEstates)
ppt15 <- crop(ppt15, extent(SEstates))
writeRaster(ppt15, "PresentLayers/ppt.asc", format="ascii", overwrite=TRUE)

tdmean15 <- mask(tdmean15, SEstates)
tdmean15 <- crop(tdmean15, extent(SEstates))
writeRaster(tdmean15, "PresentLayers/tdmean.asc", format="ascii", overwrite=TRUE)

tmax15 <- mask(tmax15, SEstates)
tmax15 <- crop(tmax15, extent(SEstates))
writeRaster(tmax15, "PresentLayers/tmax.asc", format="ascii", overwrite=TRUE)

tmean15 <- mask(tmean15, SEstates)
tmean15 <- crop(tmean15, extent(SEstates))
writeRaster(tmean15, "PresentLayers/tmean.asc", format="ascii", overwrite=TRUE)

tmin15 <- mask(tmin15, SEstates)
tmin15 <- crop(tmin15, extent(SEstates))
writeRaster(tmin15, "PresentLayers/tmin.asc", format="ascii", overwrite=TRUE)

vpdmax15 <- mask(vpdmax15, SEstates)
vpdmax15 <- crop(vpdmax15, extent(SEstates))
writeRaster(vpdmax15, "PresentLayers/vpdmax.asc", format="ascii", overwrite=TRUE)

vpdmin15 <- mask(vpdmin15, SEstates)
vpdmin15 <- crop(vpdmin15, extent(SEstates))
writeRaster(vpdmin15, "PresentLayers/vpdmin.asc", format="ascii", overwrite=TRUE)

## load contemporary layers (if not already loaded)
ppt15 <- raster("PresentLayers/ppt.asc")
tdmean15 <- raster("PresentLayers/tdmean.asc")
tmax15 <- raster("PresentLayers/tmax.asc")
tmean15 <- raster("PresentLayers/tmean.asc")
tmin15 <- raster("PresentLayers/tmin.asc")
vpdmax15 <- raster("PresentLayers/vpdmax.asc")
vpdmin15 <- raster("PresentLayers/vpdmin.asc")

## Correlation analysis for contemporary layers
stackContemp <- stack(ppt15, tdmean15, tmax15, tmean15, tmin15, vpdmax15, vpdmin15) 
corrContemp <- layerStats(stackContemp, 'pearson', na.rm=TRUE)
pearsonContemp <- corrContemp$`pearson correlation coefficient`
write.csv(pearsonContemp, "PresentLayers/correlationPRISM2015.csv")
