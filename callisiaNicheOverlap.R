## Evaluate niche overlap for diploid and tetraploid historical vs contemporary PRISM layers

library(raster)
library(dismo)

## load layers
CRS <- "+proj=longlat +datum=NAD83 +ellps=GRS80 +towgs84=0,0,0 +no_defs"
# historical
ppt <- raster("PastLayers/ppt.asc", crs=CRS)
tdmean <- raster("PastLayers/tdmean.asc", crs=CRS)
tmax <- raster("PastLayers/tmax.asc", crs=CRS)
tmean <- raster("PastLayers/tmean.asc", crs=CRS)
tmin <- raster("PastLayers/tmin.asc", crs=CRS)
vpdmax <- raster("PastLayers/vpdmax.asc", crs=CRS)
vpdmin <- raster("PastLayers/vpdmin.asc", crs=CRS)
# contemporary 
ppt15 <- raster("PresentLayers/ppt.asc", crs=CRS)
tdmean15 <- raster("PresentLayers/tdmean.asc", crs=CRS)
tmax15 <- raster("PresentLayers/tmax.asc", crs=CRS)
tmean15 <- raster("PresentLayers/tmean.asc", crs=CRS)
tmin15 <- raster("PresentLayers/tmin.asc", crs=CRS)
vpdmax15 <- raster("PresentLayers/vpdmax.asc", crs=CRS)
vpdmin15 <- raster("PresentLayers/vpdmin.asc", crs=CRS)

## diploid
dipHis <- raster("models/diploidMaxent/histDip.grd")
dipContemp <- raster("models/diploidMaxent/contempDip.grd")
nicheOverlap(dipHis, dipContemp, stat='D', mask=TRUE, checkNegatives=TRUE) #0.0634
nicheOverlap(dipHis, dipContemp, stat='I', mask=TRUE, checkNegatives=TRUE) #0.1849

## tetraploid
tetHis <- raster("models/tetraploidMaxent/histTet.grd")
tetContemp <- raster("models/tetraploidMaxent/histTetContemp.grd")
nicheOverlap(tetHis, tetContemp, stat='D', mask=TRUE, checkNegatives=TRUE) #0.4955
nicheOverlap(tetHis, tetContemp, stat='I', mask=TRUE, checkNegatives=TRUE) #0.7885
