## Averaging layers across time period

library(dismo)
library(fields)
library(maps)
library(rgdal)
library(raster)
library(maptools)
library(rJava)

# PRISM downloaded from http://www.prism.oregonstate.edu/historical/ in .bil format for precipitation, mean temperature, minimum temperature, maximum temperature, mean dewpoint temperature, minimum vapor pressure deficit, maximum vapor pressure deficit

## PPT
# load layers 
ppt40 <- raster("~/data/PRISM/PRISM_ppt_stable_4kmM2_1940_all_bil/PRISM_ppt_stable_4kmM2_1940_bil.bil")
ppt39 <- raster("~/data/PRISM/PRISM_ppt_stable_4kmM2_1939_all_bil/PRISM_ppt_stable_4kmM2_1939_bil.bil")
ppt38 <- raster("~/data/PRISM/PRISM_ppt_stable_4kmM2_1938_all_bil/PRISM_ppt_stable_4kmM2_1938_bil.bil")
ppt37 <- raster("~/data/PRISM/PRISM_ppt_stable_4kmM2_1937_all_bil/PRISM_ppt_stable_4kmM2_1937_bil.bil")
ppt36 <- raster("~/data/PRISM/PRISM_ppt_stable_4kmM2_1936_all_bil/PRISM_ppt_stable_4kmM2_1936_bil.bil")
ppt35 <- raster("~/data/PRISM/PRISM_ppt_stable_4kmM2_1935_all_bil/PRISM_ppt_stable_4kmM2_1935_bil.bil")
ppt34 <- raster("~/data/PRISM/PRISM_ppt_stable_4kmM2_1934_all_bil/PRISM_ppt_stable_4kmM2_1934_bil.bil")
ppt33 <- raster("~/data/PRISM/PRISM_ppt_stable_4kmM2_1933_all_bil/PRISM_ppt_stable_4kmM2_1933_bil.bil")
ppt32 <- raster("~/data/PRISM/PRISM_ppt_stable_4kmM2_1932_all_bil/PRISM_ppt_stable_4kmM2_1932_bil.bil")
ppt31 <- raster("~/data/PRISM/PRISM_ppt_stable_4kmM2_1931_all_bil/PRISM_ppt_stable_4kmM2_1931_bil.bil")

# stack layers
stackppt <- stack(ppt40, ppt39, ppt38, ppt37, ppt36, ppt35, ppt34, ppt33, ppt32, ppt31)
# average layers
pptMean <- calc(stackppt, fun = mean, na.rm = TRUE)
# test plot
plot(pptMean)
# save mean layer to file
writeRaster(pptMean, "~/data/PRISM/pptMean.asc", format="ascii", overwrite=TRUE)

## TDMEAN
# load layers
tdmean40 <- raster("~/data/PRISM/PRISM_tdmean_stable_4kmM1_1940_all_bil/PRISM_tdmean_stable_4kmM1_1940_bil.bil")
tdmean39 <- raster("~/data/PRISM/PRISM_tdmean_stable_4kmM1_1939_all_bil/PRISM_tdmean_stable_4kmM1_1939_bil.bil")
tdmean38 <- raster("~/data/PRISM/PRISM_tdmean_stable_4kmM1_1938_all_bil/PRISM_tdmean_stable_4kmM1_1938_bil.bil")
tdmean37 <- raster("~/data/PRISM/PRISM_tdmean_stable_4kmM1_1937_all_bil/PRISM_tdmean_stable_4kmM1_1937_bil.bil")
tdmean36 <- raster("~/data/PRISM/PRISM_tdmean_stable_4kmM1_1936_all_bil/PRISM_tdmean_stable_4kmM1_1936_bil.bil")
tdmean35 <- raster("~/data/PRISM/PRISM_tdmean_stable_4kmM1_1935_all_bil/PRISM_tdmean_stable_4kmM1_1935_bil.bil")
tdmean34 <- raster("~/data/PRISM/PRISM_tdmean_stable_4kmM1_1934_all_bil/PRISM_tdmean_stable_4kmM1_1934_bil.bil")
tdmean33 <- raster("~/data/PRISM/PRISM_tdmean_stable_4kmM1_1933_all_bil/PRISM_tdmean_stable_4kmM1_1933_bil.bil")
tdmean32 <- raster("~/data/PRISM/PRISM_tdmean_stable_4kmM1_1932_all_bil/PRISM_tdmean_stable_4kmM1_1932_bil.bil")
tdmean31 <- raster("~/data/PRISM/PRISM_tdmean_stable_4kmM1_1931_all_bil/PRISM_tdmean_stable_4kmM1_1931_bil.bil")

# stack layers
stacktdmean <- stack(tdmean40, tdmean39, tdmean38, tdmean37, tdmean36, tdmean35, tdmean34, tdmean33, tdmean32, tdmean31)
# average layers
tdmeanMean <- calc(stacktdmean, fun = mean, na.rm = TRUE)
# test plot
plot(tdmeanMean)
# save mean layer to file
writeRaster(tdmeanMean, "~/data/PRISM/tdmeanMean.asc", format="ascii", overwrite=TRUE)

## TMAX
# load layers
tmax40 <- raster("~/data/PRISM/PRISM_tmax_stable_4kmM2_1940_all_bil/PRISM_tmax_stable_4kmM2_1940_bil.bil")
tmax39 <- raster("~/data/PRISM/PRISM_tmax_stable_4kmM2_1939_all_bil/PRISM_tmax_stable_4kmM2_1939_bil.bil")
tmax38 <- raster("~/data/PRISM/PRISM_tmax_stable_4kmM2_1938_all_bil/PRISM_tmax_stable_4kmM2_1938_bil.bil")
tmax37 <- raster("~/data/PRISM/PRISM_tmax_stable_4kmM2_1937_all_bil/PRISM_tmax_stable_4kmM2_1937_bil.bil")
tmax36 <- raster("~/data/PRISM/PRISM_tmax_stable_4kmM2_1936_all_bil/PRISM_tmax_stable_4kmM2_1936_bil.bil")
tmax35 <- raster("~/data/PRISM/PRISM_tmax_stable_4kmM2_1935_all_bil/PRISM_tmax_stable_4kmM2_1935_bil.bil")
tmax34 <- raster("~/data/PRISM/PRISM_tmax_stable_4kmM2_1934_all_bil/PRISM_tmax_stable_4kmM2_1934_bil.bil")
tmax33 <- raster("~/data/PRISM/PRISM_tmax_stable_4kmM2_1933_all_bil/PRISM_tmax_stable_4kmM2_1933_bil.bil")
tmax32 <- raster("~/data/PRISM/PRISM_tmax_stable_4kmM2_1932_all_bil/PRISM_tmax_stable_4kmM2_1932_bil.bil")
tmax31 <- raster("~/data/PRISM/PRISM_tmax_stable_4kmM2_1931_all_bil/PRISM_tmax_stable_4kmM2_1931_bil.bil")

# stack layers
stacktmax <- stack(tmax40, tmax39, tmax38, tmax37, tmax36, tmax35, tmax34, tmax33, tmax32, tmax31)
# average layers
tmaxMean <- calc(stacktmax, fun = mean, na.rm = TRUE)
# test plot
plot(tmaxMean)
# save mean layer to file
writeRaster(tmaxMean, "~/data/PRISM/tmaxMean.asc", format="ascii", overwrite=TRUE)

## TMEAN
# load layers
tmean40 <- raster("~/data/PRISM/PRISM_tmean_stable_4kmM2_1940_all_bil/PRISM_tmean_stable_4kmM2_1940_bil.bil")
tmean39 <- raster("~/data/PRISM/PRISM_tmean_stable_4kmM2_1939_all_bil/PRISM_tmean_stable_4kmM2_1939_bil.bil")
tmean38 <- raster("~/data/PRISM/PRISM_tmean_stable_4kmM2_1938_all_bil/PRISM_tmean_stable_4kmM2_1938_bil.bil")
tmean37 <- raster("~/data/PRISM/PRISM_tmean_stable_4kmM2_1937_all_bil/PRISM_tmean_stable_4kmM2_1937_bil.bil")
tmean36 <- raster("~/data/PRISM/PRISM_tmean_stable_4kmM2_1936_all_bil/PRISM_tmean_stable_4kmM2_1936_bil.bil")
tmean35 <- raster("~/data/PRISM/PRISM_tmean_stable_4kmM2_1935_all_bil/PRISM_tmean_stable_4kmM2_1935_bil.bil")
tmean34 <- raster("~/data/PRISM/PRISM_tmean_stable_4kmM2_1934_all_bil/PRISM_tmean_stable_4kmM2_1934_bil.bil")
tmean33 <- raster("~/data/PRISM/PRISM_tmean_stable_4kmM2_1933_all_bil/PRISM_tmean_stable_4kmM2_1933_bil.bil")
tmean32 <- raster("~/data/PRISM/PRISM_tmean_stable_4kmM2_1932_all_bil/PRISM_tmean_stable_4kmM2_1932_bil.bil")
tmean31 <- raster("~/data/PRISM/PRISM_tmean_stable_4kmM2_1931_all_bil/PRISM_tmean_stable_4kmM2_1931_bil.bil")

# stack layers
stacktmean <- stack(tmean40, tmean39, tmean38, tmean37, tmean36, tmean35, tmean34, tmean33, tmean32, tmean31)
# average layers
tmeanMean <- calc(stacktmean, fun = mean, na.rm = TRUE)
# test plot
plot(tmeanMean)
# save mean layer to file
writeRaster(tmeanMean, "~/data/PRISM/tmeanMean.asc", format="ascii", overwrite=TRUE)

## TMIN
# load layers
tmin40 <- raster("~/data/PRISM/PRISM_tmin_stable_4kmM2_1940_all_bil/PRISM_tmin_stable_4kmM2_1940_bil.bil")
tmin39 <- raster("~/data/PRISM/PRISM_tmin_stable_4kmM2_1939_all_bil/PRISM_tmin_stable_4kmM2_1939_bil.bil")
tmin38 <- raster("~/data/PRISM/PRISM_tmin_stable_4kmM2_1938_all_bil/PRISM_tmin_stable_4kmM2_1938_bil.bil")
tmin37 <- raster("~/data/PRISM/PRISM_tmin_stable_4kmM2_1937_all_bil/PRISM_tmin_stable_4kmM2_1937_bil.bil")
tmin36 <- raster("~/data/PRISM/PRISM_tmin_stable_4kmM2_1936_all_bil/PRISM_tmin_stable_4kmM2_1936_bil.bil")
tmin35 <- raster("~/data/PRISM/PRISM_tmin_stable_4kmM2_1935_all_bil/PRISM_tmin_stable_4kmM2_1935_bil.bil")
tmin34 <- raster("~/data/PRISM/PRISM_tmin_stable_4kmM2_1934_all_bil/PRISM_tmin_stable_4kmM2_1934_bil.bil")
tmin33 <- raster("~/data/PRISM/PRISM_tmin_stable_4kmM2_1933_all_bil/PRISM_tmin_stable_4kmM2_1933_bil.bil")
tmin32 <- raster("~/data/PRISM/PRISM_tmin_stable_4kmM2_1932_all_bil/PRISM_tmin_stable_4kmM2_1932_bil.bil")
tmin31 <- raster("~/data/PRISM/PRISM_tmin_stable_4kmM2_1931_all_bil/PRISM_tmin_stable_4kmM2_1931_bil.bil")

# stack layers
stacktmin <- stack(tmin40, tmin39, tmin38, tmin37, tmin36, tmin35, tmin34, tmin33, tmin32, tmin31)
# average layers
tminMean <- calc(stacktmin, fun = mean, na.rm = TRUE)
# test plot
plot(tminMean)
# save mean layer to file
writeRaster(tminMean, "~/data/PRISM/tminMean.asc", format="ascii", overwrite=TRUE)

## VPDMAX
# load layers
vpdmax40 <- raster("~/data/PRISM/PRISM_vpdmax_stable_4kmM1_1940_all_bil/PRISM_vpdmax_stable_4kmM1_1940_bil.bil")
vpdmax39 <- raster("~/data/PRISM/PRISM_vpdmax_stable_4kmM1_1939_all_bil/PRISM_vpdmax_stable_4kmM1_1939_bil.bil")
vpdmax38 <- raster("~/data/PRISM/PRISM_vpdmax_stable_4kmM1_1938_all_bil/PRISM_vpdmax_stable_4kmM1_1938_bil.bil")
vpdmax37 <- raster("~/data/PRISM/PRISM_vpdmax_stable_4kmM1_1937_all_bil/PRISM_vpdmax_stable_4kmM1_1937_bil.bil")
vpdmax36 <- raster("~/data/PRISM/PRISM_vpdmax_stable_4kmM1_1936_all_bil/PRISM_vpdmax_stable_4kmM1_1936_bil.bil")
vpdmax35 <- raster("~/data/PRISM/PRISM_vpdmax_stable_4kmM1_1935_all_bil/PRISM_vpdmax_stable_4kmM1_1935_bil.bil")
vpdmax34 <- raster("~/data/PRISM/PRISM_vpdmax_stable_4kmM1_1934_all_bil/PRISM_vpdmax_stable_4kmM1_1934_bil.bil")
vpdmax33 <- raster("~/data/PRISM/PRISM_vpdmax_stable_4kmM1_1933_all_bil/PRISM_vpdmax_stable_4kmM1_1933_bil.bil")
vpdmax32 <- raster("~/data/PRISM/PRISM_vpdmax_stable_4kmM1_1932_all_bil/PRISM_vpdmax_stable_4kmM1_1932_bil.bil")
vpdmax31 <- raster("~/data/PRISM/PRISM_vpdmax_stable_4kmM1_1931_all_bil/PRISM_vpdmax_stable_4kmM1_1931_bil.bil")

# stack layers
stackvpdmax <- stack(vpdmax40, vpdmax39, vpdmax38, vpdmax37, vpdmax36, vpdmax35, vpdmax34, vpdmax33, vpdmax32, vpdmax31)
# average layers
vpdmaxMean <- calc(stackvpdmax, fun = mean, na.rm = TRUE)
# test plot
plot(vpdmaxMean)
# save mean layer to file
writeRaster(vpdmaxMean, "~/data/PRISM/vpdmaxMean.asc", format="ascii", overwrite=TRUE)

## VPDMIN
# load layers
vpdmin40 <- raster("~/data/PRISM/PRISM_vpdmin_stable_4kmM1_1940_all_bil/PRISM_vpdmin_stable_4kmM1_1940_bil.bil")
vpdmin39 <- raster("~/data/PRISM/PRISM_vpdmin_stable_4kmM1_1939_all_bil/PRISM_vpdmin_stable_4kmM1_1939_bil.bil")
vpdmin38 <- raster("~/data/PRISM/PRISM_vpdmin_stable_4kmM1_1938_all_bil/PRISM_vpdmin_stable_4kmM1_1938_bil.bil")
vpdmin37 <- raster("~/data/PRISM/PRISM_vpdmin_stable_4kmM1_1937_all_bil/PRISM_vpdmin_stable_4kmM1_1937_bil.bil")
vpdmin36 <- raster("~/data/PRISM/PRISM_vpdmin_stable_4kmM1_1936_all_bil/PRISM_vpdmin_stable_4kmM1_1936_bil.bil")
vpdmin35 <- raster("~/data/PRISM/PRISM_vpdmin_stable_4kmM1_1935_all_bil/PRISM_vpdmin_stable_4kmM1_1935_bil.bil")
vpdmin34 <- raster("~/data/PRISM/PRISM_vpdmin_stable_4kmM1_1934_all_bil/PRISM_vpdmin_stable_4kmM1_1934_bil.bil")
vpdmin33 <- raster("~/data/PRISM/PRISM_vpdmin_stable_4kmM1_1933_all_bil/PRISM_vpdmin_stable_4kmM1_1933_bil.bil")
vpdmin32 <- raster("~/data/PRISM/PRISM_vpdmin_stable_4kmM1_1932_all_bil/PRISM_vpdmin_stable_4kmM1_1932_bil.bil")
vpdmin31 <- raster("~/data/PRISM/PRISM_vpdmin_stable_4kmM1_1931_all_bil/PRISM_vpdmin_stable_4kmM1_1931_bil.bil")

# stack layers
stackvpdmin <- stack(vpdmin40, vpdmin39, vpdmin38, vpdmin37, vpdmin36, vpdmin35, vpdmin34, vpdmin33, vpdmin32, vpdmin31)
# average layers
vpdminMean <- calc(stackvpdmin, fun = mean, na.rm = TRUE)
# test plot
plot(vpdminMean)
# save mean layer to file
writeRaster(vpdminMean, "~/data/PRISM/vpdminMean.asc", format="ascii", overwrite=TRUE)
