## Evaluate niche overlap for diploid and tetraploid historical vs contemporary PRISM layers

library(raster)
library(dismo)

## load data
histDip <- read.csv("data/historicalDiploid.csv")
histTet <- read.csv("data/historicalTetraploid.csv")

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
# stack uncorrelated historical layers (0.75): ppt, tmean, vpdmax, vpdmin
predictorsHist <- stack(ppt, tmean, vpdmax, vpdmin)

# contemporary 
ppt15 <- raster("PresentLayers/ppt.asc", crs=CRS)
tdmean15 <- raster("PresentLayers/tdmean.asc", crs=CRS)
tmax15 <- raster("PresentLayers/tmax.asc", crs=CRS)
tmean15 <- raster("PresentLayers/tmean.asc", crs=CRS)
tmin15 <- raster("PresentLayers/tmin.asc", crs=CRS)
vpdmax15 <- raster("PresentLayers/vpdmax.asc", crs=CRS)
vpdmin15 <- raster("PresentLayers/vpdmin.asc", crs=CRS)
# stack uncorrelated contemporary layers (0.75): ppt, tmean, vpdmax, vpdmin
predictorsContemp <- stack(ppt15, tmean15, vpdmax15, vpdmin15)

# load projections
predHistHistHistDip <- raster("models/diploidHistMaxent/histHistHistDip.grd")
predHistHistHistTet <- raster("models/tetraploidHistMaxent/histHistHistTet.grd")
predHistHistContempDip <- raster("models/diploidHistMaxent/histHistContempDip.grd")
predHistHistContempTet <- raster("models/tetraploidHistMaxent/histHistContempTet.grd")
predHistContempContempDip <- raster("models/diploidContempMaxent/histContempContempDip.grd")
predHistContempContempTet <- raster("models/tetraploidContempMaxent/histContempContempTet.grd")
predContempContempContempDip <- raster("models/diploidModMaxent/contempContempContempDip.grd")
predContempContempContempTet <- raster("models/tetraploidModMaxent/contempContempContempTet.grd")

# historical diploid vs tetraploid
# compare with D and I statistics
nicheOverlap(predHistHistHistDip, predHistHistHistTet, stat='D', mask=TRUE, checkNegatives=TRUE) #0.407415
nicheOverlap(predHistHistHistDip, predHistHistHistTet, stat='I', mask=TRUE, checkNegatives=TRUE) #0.686097
# extract layer data for each point
histDipPts <- raster::extract(predictorsHist, histDip)
histDipPts <- cbind.data.frame(year ="historical", histDipPts)
histTetPts <- raster::extract(predictorsContemp, histTet)
histTetPts <- cbind.data.frame(year ="contemporary", histTetPts)
bothDipPts <- as.data.frame(rbind(histDipPts, histTetPts))
# ANOVA
aov.ppt.hist <- aov(ppt ~ year, data=bothDipPts)
summary(aov.ppt.hist) #<2e-16 ***
aov.tmean.hist <- aov(tmean ~ year, data=bothDipPts)
summary(aov.tmean.hist) #<2e-16 ***
aov.vpdmax.hist <- aov(vpdmax ~ year, data=bothDipPts)
summary(aov.vpdmax.hist) #0.782
aov.vpdmin.hist <- aov(vpdmin ~ year, data=bothDipPts)
summary(aov.vpdmin.hist) #0.00779 **

## historical occurrence with contemporary model and projections
# compare with D and I statistics
nicheOverlap(predHistContempContempDip, predHistContempContempTet, stat='D', mask=TRUE, checkNegatives=TRUE) #0.4490552
nicheOverlap(predHistContempContempDip, predHistContempContempTet, stat='I', mask=TRUE, checkNegatives=TRUE) #0.7583

## diploid: historical vs. contemporary
# compare with D and I statistics
nicheOverlap(predHistHistHistDip, predHistContempContempDip, stat='D', mask=TRUE, checkNegatives=TRUE) #0.4595912
nicheOverlap(predHistHistHistDip, predHistContempContempDip, stat='I', mask=TRUE, checkNegatives=TRUE) #0.69658
# extract layer data for each point
histDipPts <- raster::extract(predictorsHist, histDip)
histDipPts <- cbind.data.frame(year ="historical", histDipPts)
contempDipPts <- raster::extract(predictorsContemp, histDip)
contempDipPts <- cbind.data.frame(year ="contemporary", contempDipPts)
bothDipPts <- as.data.frame(rbind(histDipPts, contempDipPts))
# ANOVA
aov.ppt.hist <- aov(ppt ~ year, data=bothDipPts)
summary(aov.ppt.hist) #<2e-16 ***
aov.tmean.hist <- aov(tmean ~ year, data=bothDipPts)
summary(aov.tmean.hist) #<2e-16 ***
aov.vpdmax.hist <- aov(vpdmax ~ year, data=bothDipPts)
summary(aov.vpdmax.hist) #0.00138 **
aov.vpdmin.hist <- aov(vpdmin ~ year, data=bothDipPts)
summary(aov.vpdmin.hist) #0.00705 **

## tetraploid
# compare with D and I statistics
nicheOverlap(predHistHistHistTet, predHistContempContempTet, stat='D', mask=TRUE, checkNegatives=TRUE) #0.7735
nicheOverlap(predHistHistHistTet, predHistContempContempTet, stat='I', mask=TRUE, checkNegatives=TRUE) #0.9455296
# extract layer data for each point
histTetPts <- raster::extract(predictorsHist, histTet)
histTetPts <- cbind.data.frame(year="historical", histTetPts)
contempTetPts <- raster::extract(predictorsContemp, histTet)
contempTetPts <- cbind.data.frame(year="contemporary", contempTetPts)
bothTetPts <- as.data.frame(rbind(histTetPts, contempTetPts))
# ANOVA
aov.ppt.contemp <- aov(ppt ~ year, data=bothTetPts)
summary(aov.ppt.contemp) #<2e-16 ***
aov.tmean.contemp <- aov(tmean ~ year, data=bothTetPts)
summary(aov.tmean.contemp) #1.57e-11 ***
aov.vpdmax.contemp <- aov(vpdmax ~ year, data=bothTetPts)
summary(aov.vpdmax.contemp) #0.986
aov.vpdmin.contemp <- aov(vpdmin ~ year, data=bothTetPts)
summary(aov.vpdmin.contemp) #2.07e-08 ***
